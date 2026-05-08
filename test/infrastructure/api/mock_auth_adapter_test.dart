// Prueba unitaria de MockAuthAdapter
// Se verifica que el adaptador mock retorna datos
// con la estructura correcta que el sistema espera

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/infrastructure/api/mock_auth_adapter.dart';
import 'package:finansys/infrastructure/storage/local_storage_adapter.dart';

void main() {
  group('MockAuthAdapter', () {
    late MockAuthAdapter adapter;

    setUp(() {
      adapter = MockAuthAdapter(LocalStorageAdapter());
    });

    test('login() retorna usuario con email correcto', () async {
      final result = await adapter.login(
        email:    'test@ejemplo.com',
        password: '123456',
      );

      expect(result.user.email, isNotEmpty);
      expect(result.token,      isNotEmpty);
    });

    test('login() retorna token no vacío', () async {
      final result = await adapter.login(
        email:    'test@ejemplo.com',
        password: '123456',
      );

      expect(result.token, equals('mock-token-finansys-2026'));
    });

    test('register() retorna el username ingresado', () async {
      final result = await adapter.register(
        email:    'nuevo@ejemplo.com',
        password: '123456',
        username: 'NuevoUsuario',
      );

      expect(result.user.username, equals('NuevoUsuario'));
    });

    test('getProfile() retorna usuario con uid mayor a 0', () async {
      final user = await adapter.getProfile();

      expect(user.uid, greaterThan(0));
    });

    test('getUsers() retorna lista con al menos un usuario', () async {
      final users = await adapter.getUsers();

      expect(users, isNotEmpty);
    });
  });
}