// Prueba unitaria de LoginUseCase
// Se verifica que el caso de uso llama al puerto correctamente
// y retorna el usuario y token esperados

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/application/usecases/login_usecase.dart';
import 'package:finansys/domain/entities/user_entity.dart';
import 'package:finansys/domain/ports/auth_port.dart';

// Mock manual del puerto de autenticación
class MockAuthPort implements AuthPort {
  @override
  Future<({UserEntity user, String token})> login({
    required String email,
    required String password,
  }) async {
    return (
      user: const UserEntity(uid: 1, email: 'juan@ejemplo.com', username: 'Juan'),
      token: 'mock-token-123',
    );
  }

  @override
  Future<({UserEntity user, String token})> register({
    required String email,
    required String password,
    required String username,
  }) async => throw UnimplementedError();

  @override
  Future<UserEntity> getProfile() async => throw UnimplementedError();

  @override
  Future<List<UserEntity>> getUsers() async => throw UnimplementedError();
}

void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late MockAuthPort mockAuthPort;

    setUp(() {
      mockAuthPort = MockAuthPort();
      loginUseCase = LoginUseCase(mockAuthPort);
    });

    test('execute() retorna usuario y token correctamente', () async {
      final result = await loginUseCase.execute(
        email:    'juan@ejemplo.com',
        password: '123456',
      );

      expect(result.user.email, equals('juan@ejemplo.com'));
      expect(result.token,      equals('mock-token-123'));
    });

    test('execute() retorna el uid correcto del usuario', () async {
      final result = await loginUseCase.execute(
        email:    'juan@ejemplo.com',
        password: '123456',
      );

      expect(result.user.uid, equals(1));
    });
  });
}