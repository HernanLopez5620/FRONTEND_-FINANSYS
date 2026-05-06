// presentation/providers/auth_provider.dart
// SOLID-SRP: gestiona únicamente el estado de autenticación.

import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../container.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? _user;
  bool _loading = false;
  bool _isAuthenticated = false;
  String? _error;

  UserEntity? get user => _user;
  bool get loading => _loading;
  bool get isAuthenticated => _isAuthenticated;
  String? get error => _error;

  // Verifica si hay token guardado al iniciar la app
  Future<void> checkAuthStatus() async {
    _loading = true;
    notifyListeners();
    try {
      final user = await Container.getProfileUseCase.execute();
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
      final result = await Container.loginUseCase.execute(
        email: email,
        password: password,
      );
      _user = result.user;
      _isAuthenticated = true;
      await Container.storage.saveToken(result.token);
      return true;
    } catch (e) {
      _error = e.toString();
      print('ERROR LOGIN: $e'); // ← agregar esto
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String email, String password, String username) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final result = await Container.registerUseCase.execute(
        email: email,
        password: password,
        username: username,
      );
      _user = result.user;
      _isAuthenticated = true;
      await Container.storage.saveToken(result.token); // ← agregar esta línea
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
    await Container.logoutUseCase.execute();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
