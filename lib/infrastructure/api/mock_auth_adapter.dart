// infrastructure/api/mock_auth_adapter.dart
// Adaptador MOCK — para desarrollo sin backend activo.
// SOLID-LSP: reemplaza a AuthApiAdapter sin romper nada.

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';
import '../../domain/ports/storage_port.dart';

class MockAuthAdapter implements AuthPort {
  final StoragePort _storage;
  static const _mockToken = 'mock-token-finansys-2026';

  MockAuthAdapter(this._storage);

  @override
  Future<({UserEntity user, String token})> register({
    required String email,
    required String password,
    required String nombre,
    required String username,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    await _storage.saveToken(_mockToken);

    return (
      user: UserEntity(
        uid: 1,
        email: email,
        nombre: nombre,
        username: username,
      ),
      token: _mockToken,
    );
  }

  @override
  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    await _storage.saveToken(_mockToken);

    return (
      user: const UserEntity(
        uid: 1,
        email: 'juan@ejemplo.com',
        nombre: 'Juan García',
        username: 'juangarcia123',
      ),
      token: _mockToken,
    );
  }

  @override
  Future<UserEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const UserEntity(
      uid: 1,
      email: 'juan@ejemplo.com',
      nombre: 'Juan García',
      username: 'juangarcia123',
    );
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const [
      UserEntity(
        uid: 1,
        email: 'juan@ejemplo.com',
        nombre: 'Juan García',
        username: 'juangarcia123',
      ),
      UserEntity(
        uid: 2,
        email: 'maria@ejemplo.com',
        nombre: 'María López',
        username: 'marialopez456',
      ),
    ];
  }

  @override
  Future<UserEntity> updateProfile({
    String? nombre,
    String? username,
    String? password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return UserEntity(
      uid: 1,
      email: 'juan@ejemplo.com',
      nombre: nombre ?? 'Juan García',
      username: username ?? 'juangarcia123',
    );
  }

  @override
  Future<({bool disponible, String msg})> checkUsername(
    String username,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return (
      disponible: true,
      msg: 'Usuario disponible',
    );
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateTema(String tema) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> checkSession() async {}
}
