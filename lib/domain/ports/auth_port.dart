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
    required String nombre,
    required String username,
  });

  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  });

  Future<UserEntity> getProfile();
  Future<List<UserEntity>> getUsers();

  Future<UserEntity> updateProfile({
    String? nombre,
    String? username,
    String? password,
  });

  Future<({bool disponible, String msg})> checkUsername(String username);
}
