// infrastructure/storage/local_storage_adapter.dart
// Adaptador de salida — implementa StoragePort.
// SharedPreferences usa automáticamente la implementación apropiada
// para Web, Windows, Android, iOS y otras plataformas compatibles.

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/env/app_env.dart';
import '../../domain/ports/storage_port.dart';

class LocalStorageAdapter implements StoragePort {
  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppEnv.tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppEnv.tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppEnv.tokenKey);
  }

  @override
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
