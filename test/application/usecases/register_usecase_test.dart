// Prueba unitaria de RegisterUseCase
// Se verifica que el caso de uso registra correctamente

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/application/usecases/register_usecase.dart';
import 'package:finansys/domain/entities/user_entity.dart';
import 'package:finansys/domain/ports/auth_port.dart';

class MockAuthPort implements AuthPort {
  @override
  Future<({UserEntity user, String token})> register({
    required String email,
    required String password,
    required String username,
  }) async {
    return (
      user: UserEntity(uid: 1, email: email, username: username),
      token: 'mock-token-register',
    );
  }

  @override
  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  }) async => throw UnimplementedError();

  @override
  Future<UserEntity> getProfile() async => throw UnimplementedError();

  @override
  Future<List<UserEntity>> getUsers() async => throw UnimplementedError();
}

void main() {
  group('RegisterUseCase', () {
    late RegisterUseCase registerUseCase;

    setUp(() {
      registerUseCase = RegisterUseCase(MockAuthPort());
    });

    test('execute() registra y retorna usuario correctamente', () async {
      final result = await registerUseCase.execute(
        email:    'nuevo@ejemplo.com',
        password: '123456',
        username: 'NuevoUsuario',
      );

      expect(result.user.email,    equals('nuevo@ejemplo.com'));
      expect(result.user.username, equals('NuevoUsuario'));
      expect(result.token,         equals('mock-token-register'));
    });
  });
}