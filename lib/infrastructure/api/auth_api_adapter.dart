// infrastructure/api/auth_api_adapter.dart
// Adaptador REAL — implementa AuthPort conectando al backend.
// Correlacionado con user.routes.js y user.controller.js

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';
import 'http_client.dart';

class AuthApiAdapter implements AuthPort {
  final HttpClient _http;
  AuthApiAdapter(this._http);

  @override
  Future<({UserEntity user, String token})> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final res = await _http.post('/users/register', {
      'email': email,
      'password': password,
      'username': username,
    });
    return (
      user: UserEntity.fromJson(res['user'] ?? {}),
      token: res['token'] as String
    );
  }

  @override
  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  }) async {
    final res = await _http.post('/users/login', {
      'email': email,
      'password': password,
    });
    return (
      user: UserEntity.fromJson(res['user'] ?? {}),
      token: res['token'] as String
    );
  }

  @override
  Future<UserEntity> getProfile() async {
    final res = await _http.get('/users/profile', requiresAuth: true);
    return UserEntity.fromJson(res['user'] ?? {});
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    final res = await _http.get('/users/', requiresAuth: true);
    final data = res['users'] as List? ?? [];
    return data.map((e) => UserEntity.fromJson(e)).toList();
  }

  @override
  Future<UserEntity> updateProfile({String? username, String? password}) async {
    final body = <String, dynamic>{};
    if (username != null && username.isNotEmpty) body['username'] = username;
    if (password != null && password.isNotEmpty) body['password'] = password;
    final res = await _http.put('/users/profile', body, requiresAuth: true);
    return UserEntity.fromJson(res['user'] ?? {});
  }
}
