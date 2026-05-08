// Prueba unitaria de CategoriaEntity
// Se verifica que fromJson() parsea los datos del backend
// y que toJson() genera el body correcto para POST /categorias

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/categoria_entity.dart';

void main() {
  group('CategoriaEntity', () {

    test('fromJson() parsea correctamente una categoría', () {
      final json = {
        'id':     1,
        'nombre': 'Arriendo',
        'icono':  '🏠',
        'color':  '#1A7A3C',
        'tipo':   'gasto',
      };

      final cat = CategoriaEntity.fromJson(json);

      expect(cat.id,     equals(1));
      expect(cat.nombre, equals('Arriendo'));
      expect(cat.icono,  equals('🏠'));
      expect(cat.color,  equals('#1A7A3C'));
      expect(cat.tipo,   equals('gasto'));
    });

    test('fromJson() usa valores por defecto si faltan campos', () {
      final cat = CategoriaEntity.fromJson({'id': 1, 'nombre': 'Test'});

      expect(cat.icono, equals('📦'));
      expect(cat.color, equals('#1A7A3C'));
      expect(cat.tipo,  equals('gasto'));
    });

    test('toJson() genera el body correcto para POST /categorias', () {
      const cat = CategoriaEntity(
        id:     0,
        nombre: 'Mercado',
        icono:  '🛒',
        color:  '#E74C3C',
        tipo:   'gasto',
      );

      final json = cat.toJson();

      expect(json['nombre'], equals('Mercado'));
      expect(json['icono'],  equals('🛒'));
      expect(json['color'],  equals('#E74C3C'));
      expect(json['tipo'],   equals('gasto'));
      expect(json.containsKey('id'), isFalse);
    });
  });
}