import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/errors/app_errors.dart';
import '../../core/session/session_events.dart';
import '../../domain/entities/user_entity.dart';
import '../../container.dart' as AppContainer;

// SOLID-SRP: gestiona únicamente el estado de autenticación.
//
// Sesión única:
// si la misma cuenta se abre en otra ventana o dispositivo,
// esta sesión se cierra automáticamente y se muestra un aviso.

class AuthProvider extends ChangeNotifier {
  static const _intervaloLatido = Duration(seconds: 20);

  static const _msgReemplazada =
      'Tu cuenta se abrió en otra ventana o dispositivo, '
      'por eso se cerró esta sesión.';

  static const _msgCerrada =
      'Tu sesión ya no es válida. Inicia sesión de nuevo.';

  UserEntity? _user;

  bool _loading = false;
  bool _isAuthenticated = false;

  String? _error;

  // Token correspondiente a ESTA ventana/sesión.
  //
  // Se utiliza para detectar cuando otra pestaña o dispositivo
  // inició una sesión nueva con la misma cuenta.
  String? _token;

  Timer? _latido;

  bool _latiendo = false;

  // Mensaje que se muestra en el login cuando la sesión
  // fue cerrada por otra ventana/dispositivo.
  String? _aviso;

  AuthProvider() {
    // El cliente HTTP nos avisa cuando el servidor invalida
    // esta sesión.
    SessionEvents.onInvalid = _onSesionInvalida;
  }

  // ─────────────────────────────────────────────
  // Getters
  // ─────────────────────────────────────────────

  UserEntity? get user => _user;

  bool get loading => _loading;

  bool get isAuthenticated => _isAuthenticated;

  String? get error => _error;

  /// Mensaje que se muestra en el login cuando la sesión
  /// fue cerrada por otra ventana o dispositivo.
  String? get aviso => _aviso;

  // ─────────────────────────────────────────────
  // Avisos
  // ─────────────────────────────────────────────

  void limpiarAviso() {
    if (_aviso != null) {
      _aviso = null;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // Comprobar autenticación al iniciar la aplicación
  // ─────────────────────────────────────────────

  Future<void> checkAuthStatus() async {
    _loading = true;
    notifyListeners();

    try {
      // Recuperamos el token correspondiente a esta ventana.
      _token = await AppContainer.Container.storage.getToken();

      final user = await AppContainer.Container.getProfileUseCase.execute();

      if (user != null) {
        _user = user;
        _isAuthenticated = true;

        _iniciarLatido();
      } else {
        _isAuthenticated = false;
        _token = null;
      }
    } on SessionReplacedError catch (e) {
      // El token corresponde a una sesión que ya fue reemplazada.
      await AppContainer.Container.storage.deleteToken();

      _token = null;
      _isAuthenticated = false;
      _user = null;

      if (e.code == 'SESION_REEMPLAZADA') {
        _aviso = _msgReemplazada;
      }
    } catch (_) {
      _isAuthenticated = false;
      _user = null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // Login
  // ─────────────────────────────────────────────

  Future<bool> login(
    String email,
    String password,
  ) async {
    _loading = true;
    _error = null;
    _aviso = null;

    notifyListeners();

    try {
      final result = await AppContainer.Container.loginUseCase.execute(
        email: email,
        password: password,
      );

      _user = result.user;
      _isAuthenticated = true;

      // Guardamos el token de ESTA sesión.
      await AppContainer.Container.storage.saveToken(
        result.token,
      );

      _token = result.token;

      // Recargamos el perfil completo para obtener todos
      // los datos actualizados del usuario.
      try {
        final fullUser =
            await AppContainer.Container.getProfileUseCase.execute();

        if (fullUser != null) {
          _user = fullUser;
        }
      } catch (_) {
        // Si falla la recarga del perfil, conservamos
        // los datos devueltos por login.
      }

      // Iniciamos el control periódico de sesión.
      _iniciarLatido();

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // Registro
  // ─────────────────────────────────────────────

  Future<bool> register(
    String email,
    String password,
    String nombre,
    String username,
  ) async {
    _loading = true;
    _error = null;
    _aviso = null;

    notifyListeners();

    try {
      final result = await AppContainer.Container.registerUseCase.execute(
        email: email,
        password: password,
        nombre: nombre,
        username: username,
      );

      _user = result.user;
      _isAuthenticated = true;

      // Guardamos el token de la nueva sesión.
      await AppContainer.Container.storage.saveToken(
        result.token,
      );

      _token = result.token;

      // Iniciamos el control de sesión única.
      _iniciarLatido();

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // Logout
  // ─────────────────────────────────────────────

  Future<void> logout() async {
    _detenerLatido();

    await AppContainer.Container.logoutUseCase.execute();

    _user = null;
    _token = null;
    _isAuthenticated = false;

    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // Actualizar perfil
  // ─────────────────────────────────────────────

  Future<bool> updateProfile({
    String? nombre,
    String? username,
    String? password,
  }) async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      final user = await AppContainer.Container.updateProfileUseCase.execute(
        nombre: nombre,
        username: username,
        password: password,
      );

      _user = user;

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // Sesión única
  // ─────────────────────────────────────────────

  /// El servidor respondió 401 con:
  /// SESION_REEMPLAZADA / SESION_CERRADA.
  void _onSesionInvalida(
    String code,
    String msg,
  ) {
    if (!_isAuthenticated) return;

    _expulsar(
      code == 'SESION_REEMPLAZADA' ? _msgReemplazada : _msgCerrada,
    );
  }

  /// Cierra solamente ESTA ventana.
  ///
  /// No toca la sesión activa del servidor.
  /// Deja el aviso para mostrarlo en el login.
  Future<void> _expulsar(String mensaje) async {
    if (!_isAuthenticated) return;

    _detenerLatido();

    // Solo eliminamos el token si sigue siendo el nuestro.
    //
    // Si otra pestaña del mismo navegador ya guardó un token
    // nuevo, ese token pertenece a la sesión activa y no debemos
    // eliminarlo.
    final guardado = await AppContainer.Container.storage.getToken();

    if (guardado == _token) {
      await AppContainer.Container.storage.deleteToken();
    }

    _user = null;
    _token = null;
    _isAuthenticated = false;
    _aviso = mensaje;

    notifyListeners();
  }

  /// Cierre silencioso cuando la sesión fue cerrada
  /// voluntariamente desde otra pestaña.
  void _cerrarLocalSilencioso() {
    if (!_isAuthenticated) return;

    _detenerLatido();

    _user = null;
    _token = null;
    _isAuthenticated = false;

    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // Latido de sesión
  // ─────────────────────────────────────────────

  void _iniciarLatido() {
    _detenerLatido();

    _latido = Timer.periodic(
      _intervaloLatido,
      (_) => _latir(),
    );
  }

  void _detenerLatido() {
    _latido?.cancel();
    _latido = null;
  }

  /// Cada aproximadamente 20 segundos:
  ///
  /// 1. Comprueba si todavía existe un token.
  /// 2. Comprueba si el token pertenece a esta ventana.
  /// 3. Consulta al servidor para comprobar que la sesión
  ///    todavía sea válida.
  Future<void> _latir() async {
    if (_latiendo || !_isAuthenticated || _token == null) {
      return;
    }

    _latiendo = true;

    try {
      final guardado = await AppContainer.Container.storage.getToken();

      // Otra pestaña cerró sesión.
      if (guardado == null) {
        _cerrarLocalSilencioso();
        return;
      }

      // Otra pestaña/dispositivo inició una nueva sesión.
      if (guardado != _token) {
        await _expulsar(_msgReemplazada);
        return;
      }

      // Validación contra el servidor.
      await AppContainer.Container.checkSessionUseCase.execute();
    } on SessionReplacedError {
      // SessionEvents.onInvalid ya se encarga de gestionar
      // la expulsión.
    } catch (_) {
      // Sin conexión u otro error:
      // se reintentará en el siguiente latido.
    } finally {
      _latiendo = false;
    }
  }

  // ─────────────────────────────────────────────
  // Dispose
  // ─────────────────────────────────────────────

  @override
  void dispose() {
    _detenerLatido();

    if (SessionEvents.onInvalid == _onSesionInvalida) {
      SessionEvents.onInvalid = null;
    }

    super.dispose();
  }
}
