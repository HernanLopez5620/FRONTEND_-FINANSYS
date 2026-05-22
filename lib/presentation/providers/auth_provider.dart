// presentation/providers/auth_provider.dart
// SOLID-SRP: gestiona únicamente el estado de autenticación.

import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../container.dart' as AppContainer;

class AuthProvider extends ChangeNotifier {
  UserEntity? _user;
  bool _loading = false;
  bool _isAuthenticated = false;
  String? _error;

  UserEntity? get user => _user;
  bool get loading => _loading;
  bool get isAuthenticated => _isAuthenticated;
  String? get error => _error;

  Future<void> checkAuthStatus() async {
    _loading = true;
    notifyListeners();
    try {
      final user = await AppContainer.Container.getProfileUseCase.execute();
      if (user != null) {
        _user = user;
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
      }
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
    notifyListeners();
    try {
      final result = await AppContainer.Container.loginUseCase.execute(
        email: email,
        password: password,
      );
      _user = result.user;
      _isAuthenticated = true;
      await AppContainer.Container.storage.saveToken(result.token);

      // ← Recargar perfil completo para obtener nombre
      try {
        final fullUser =
            await AppContainer.Container.getProfileUseCase.execute();
        if (fullUser != null) _user = fullUser;
      } catch (_) {}

      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> register(
      String email, String password, String nombre, String username) async {
    _loading = true;
    _error = null;
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
      await AppContainer.Container.storage.saveToken(result.token);
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
    await AppContainer.Container.logoutUseCase.execute();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> updateProfile(
      {String? nombre, String? username, String? password}) async {
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
}
