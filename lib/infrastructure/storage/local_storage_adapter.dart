// infrastructure/storage/local_storage_adapter.dart
// Adaptador de salida — implementa StoragePort.
// En web usa localStorage directamente para garantizar persistencia.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/env/app_env.dart';
import '../../domain/ports/storage_port.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class LocalStorageAdapter implements StoragePort {
  @override
  Future<void> saveToken(String token) async {
    if (kIsWeb) {
      html.window.localStorage[AppEnv.tokenKey] = token;
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppEnv.tokenKey, token);
    }
  }

  @override
  Future<String?> getToken() async {
    if (kIsWeb) {
      final token = html.window.localStorage[AppEnv.tokenKey];
      return token?.isEmpty == true ? null : token;
    } else {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(AppEnv.tokenKey);
    }
  }

  @override
  Future<void> deleteToken() async {
    if (kIsWeb) {
      html.window.localStorage.remove(AppEnv.tokenKey);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppEnv.tokenKey);
    }
  }

  @override
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }
}
