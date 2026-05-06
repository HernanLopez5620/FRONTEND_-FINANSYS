// domain/ports/auth_port.dart
// POST /api/v1/users/register
// POST /api/v1/users/login
// GET  /api/v1/users/profile
// GET  /api/v1/users/

import '../entities/user_entity.dart';

abstract class AuthPort {
  Future<({UserEntity user, String token})> register({
    required String email,
    required String password,
    required String username,
  });

  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  });

  Future<UserEntity> getProfile();

  Future<List<UserEntity>> getUsers();
}
