// infrastructure/api/auth_api_adapter.dart
// Adaptador REAL — implementa AuthPort conectando al backend.
// Correlacionado con user.routes.js y user.controller.js

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';
import 'http_client.dart';

class AuthApiAdapter implements AuthPort {
  final HttpClient _http;

  AuthApiAdapter(this._http);

  // POST /api/v1/users/register
  // Body: { email, password, username }
  // Response: { ok: true, user, token }
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
    final token = res['token'] as String;
    final user = UserEntity.fromJson(res['user'] ?? {});
    return (user: user, token: token);
  }

  // POST /api/v1/users/login
  // Body: { email, password }
  // Response: { ok: true, user, token }
  @override
  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  }) async {
    final res = await _http.post('/users/login', {
      'email': email,
      'password': password,
    });
    final token = res['token'] as String;
    final user = UserEntity.fromJson(res['user'] ?? {});
    return (user: user, token: token);
  }

  // GET /api/v1/users/profile  (requiere JWT)
  // Response: { ok: true, user }
  @override
  Future<UserEntity> getProfile() async {
    final res = await _http.get('/users/profile', requiresAuth: true);
    return UserEntity.fromJson(res['user'] ?? {});
  }

  // GET /api/v1/users/
  // Response: { ok: true, users: [] }
  @override
  Future<List<UserEntity>> getUsers() async {
    final res = await _http.get('/users/', requiresAuth: true);
    final data = res['users'] as List? ?? [];
    return data.map((e) => UserEntity.fromJson(e)).toList();
  }
}
