// Prueba unitaria de UserEntity
// Se verifica que fromJson() parsea correctamente los datos
// que retorna el backend en /api/v1/users/profile

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('fromJson() parsea correctamente los campos del backend', () {
      final json = {
        'uid': 1,
        'email': 'juan@ejemplo.com',
        'nombre': 'Juan García',
        'username': 'Juan García',
      };

      final user = UserEntity.fromJson(json);

      expect(user.uid, equals(1));
      expect(user.email, equals('juan@ejemplo.com'));
      expect(user.nombre, equals('Juan García'));
      expect(user.username, equals('Juan García'));
    });

    test('fromJson() acepta id en lugar de uid', () {
      final json = {
        'id': 2,
        'email': 'maria@ejemplo.com',
        'nombre': 'María López',
        'username': 'María López',
      };

      final user = UserEntity.fromJson(json);

      expect(user.uid, equals(2));
      expect(user.nombre, equals('María López'));
    });

    test('fromJson() usa valores por defecto si faltan campos', () {
      final user = UserEntity.fromJson({});

      expect(user.uid, equals(0));
      expect(user.email, equals(''));
      expect(user.nombre, equals(''));
      expect(user.username, equals(''));
    });

    test('toJson() retorna el mapa correcto', () {
      const user = UserEntity(
        uid: 1,
        email: 'juan@ejemplo.com',
        nombre: 'Juan García',
        username: 'Juan García',
      );

      final json = user.toJson();

      expect(json['uid'], equals(1));
      expect(json['email'], equals('juan@ejemplo.com'));
      expect(json['nombre'], equals('Juan García'));
      expect(json['username'], equals('Juan García'));
    });
  });
}
