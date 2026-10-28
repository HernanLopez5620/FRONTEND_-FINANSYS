// presentation/providers/auth_provider.dart
// SOLID-SRP: gestiona únicamente el estado de autenticación.
// Sesión única (como WhatsApp Web): si la cuenta se abre en otra ventana o
// dispositivo, esta sesión se cierra sola y se muestra un aviso.

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../core/errors/app_errors.dart';
import '../../core/session/session_events.dart';
import '../../domain/entities/user_entity.dart';
import '../../container.dart';

class AuthProvider extends ChangeNotifier {
  static const _intervaloLatido = Duration(seconds: 20);
  static const _msgReemplazada =
      'Tu cuenta se abrió en otra ventana o dispositivo, por eso se cerró esta sesión.';
  static const _msgCerrada =
      'Tu sesión ya no es válida. Inicia sesión de nuevo.';

  UserEntity? _user;
  bool _loading = false;
  bool _isAuthenticated = false;
  String? _error;

  // Token de ESTA ventana (para detectar que otra pestaña inició sesión)
  String? _token;
  Timer? _latido;
  bool _latiendo = false;
  String? _aviso;

  AuthProvider() {
    // El cliente HTTP nos avisa cuando el servidor invalida esta sesión
    SessionEvents.onInvalid = _onSesionInvalida;
  }

  UserEntity? get user => _user;
  bool get loading => _loading;
  bool get isAuthenticated => _isAuthenticated;
  String? get error => _error;

  /// Mensaje a mostrar en el login cuando la sesión se cerró por otra ventana.
  String? get aviso => _aviso;

  void limpiarAviso() {
    if (_aviso != null) {
      _aviso = null;
      notifyListeners();
    }
  }

  // Verifica si hay token guardado al iniciar la app
  Future<void> checkAuthStatus() async {
    _loading = true;
    notifyListeners();
    try {
      _token = await Container.storage.getToken();
      final user = await Container.getProfileUseCase.execute();
      if (user != null) {
        _user = user;
        _isAuthenticated = true;
        _iniciarLatido();
      } else {
        _isAuthenticated = false;
      }
    } on SessionReplacedError catch (e) {
      // Token de una sesión que ya no es la activa: se descarta
      await Container.storage.deleteToken();
      _token = null;
      _isAuthenticated = false;
      if (e.code == 'SESION_REEMPLAZADA') _aviso = _msgReemplazada;
    } catch (_) {
      _isAuthenticated = false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _loading = true;
    _error = null;
    _aviso = null;
    notifyListeners();
    try {
      final result = await Container.loginUseCase.execute(
        email: email,
        password: password,
      );
      _user = result.user;
      _isAuthenticated = true;
      await Container.storage.saveToken(result.token);
      _token = result.token;
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

  // Se agregó 'String nombre' a los parámetros
  Future<bool> register(
      String email, String password, String username, String nombre) async {
    _loading = true;
    _error = null;
    _aviso = null;
    notifyListeners();
    try {
      final result = await Container.registerUseCase.execute(
        email: email,
        password: password,
        username: username,
        nombre: nombre,
      );
      _user = result.user;
      _isAuthenticated = true;
      await Container.storage.saveToken(result.token);
      _token = result.token;
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

  Future<void> logout() async {
    _detenerLatido();
    await Container.logoutUseCase.execute();
    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> updateProfile(
      {String? username, String? password, String? nombre}) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final user = await Container.updateProfileUseCase.execute(
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

  // ───────────────── Sesión única ─────────────────

  // El servidor respondió 401 con SESION_REEMPLAZADA / SESION_CERRADA
  void _onSesionInvalida(String code, String msg) {
    if (!_isAuthenticated) return;
    _expulsar(code == 'SESION_REEMPLAZADA' ? _msgReemplazada : _msgCerrada);
  }

  // Cierra SOLO esta ventana (no toca al servidor) y deja el aviso en el login
  Future<void> _expulsar(String mensaje) async {
    if (!_isAuthenticated) return;
    _detenerLatido();
    // Solo borramos el token si sigue siendo el nuestro: si otra pestaña del mismo
    // navegador ya guardó uno nuevo, ese pertenece a la sesión activa y no se toca.
    final guardado = await Container.storage.getToken();
    if (guardado == _token) await Container.storage.deleteToken();
    _user = null;
    _token = null;
    _isAuthenticated = false;
    _aviso = mensaje;
    notifyListeners();
  }

  // Cierre silencioso: la sesión se cerró voluntariamente en otra pestaña
  void _cerrarLocalSilencioso() {
    if (!_isAuthenticated) return;
    _detenerLatido();
    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  void _iniciarLatido() {
    _detenerLatido();
    _latido = Timer.periodic(_intervaloLatido, (_) => _latir());
  }

  void _detenerLatido() {
    _latido?.cancel();
    _latido = null;
  }

  // Cada ~20 s: detecta que otra pestaña inició/cerró sesión, y consulta al servidor
  // (así una ventana inactiva también se entera de que fue reemplazada).
  Future<void> _latir() async {
    if (_latiendo || !_isAuthenticated || _token == null) return;
    _latiendo = true;
    try {
      final guardado = await Container.storage.getToken();
      if (guardado == null) {
        _cerrarLocalSilencioso(); // se cerró sesión en otra pestaña
        return;
      }
      if (guardado != _token) {
        await _expulsar(_msgReemplazada); // otra pestaña inició sesión
        return;
      }
      await Container.checkSessionUseCase.execute();
    } on SessionReplacedError {
      // ya gestionado por SessionEvents.onInvalid
    } catch (_) {
      // sin conexión u otro error: se reintenta en el próximo latido
    } finally {
      _latiendo = false;
    }
  }

  @override
  void dispose() {
    _detenerLatido();
    if (SessionEvents.onInvalid == _onSesionInvalida) {
      SessionEvents.onInvalid = null;
    }
    super.dispose();
  }
}
