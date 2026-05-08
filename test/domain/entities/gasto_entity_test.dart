// Prueba unitaria de GastoEntity
// Se verifica que fromJson() parsea los datos del backend
// y que toCreateJson() y toUpdateJson() generan el body correcto

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/gasto_entity.dart';

void main() {
  group('GastoEntity', () {

    test('fromJson() parsea correctamente un gasto', () {
      final json = {
        'id':           1,
        'user_id':      1,
        'categoria_id': 2,
        'monto':        '150000',
        'descripcion':  'Factura de luz',
        'fecha':        '2026-04-02',
        'tipo':         'gasto',
        'categoria':    'Luz',
        'icono':        '⚡',
        'color':        '#E67E22',
      };

      final gasto = GastoEntity.fromJson(json);

      expect(gasto.id,          equals(1));
      expect(gasto.monto,       equals(150000.0));
      expect(gasto.descripcion, equals('Factura de luz'));
      expect(gasto.tipo,        equals('gasto'));
      expect(gasto.icono,       equals('⚡'));
    });

    test('fromJson() parsea correctamente un ingreso', () {
      final json = {
        'id':    6,
        'monto': '5800000',
        'tipo':  'ingreso',
        'fecha': '2026-04-01',
        'descripcion': 'Salario abril',
      };

      final gasto = GastoEntity.fromJson(json);

      expect(gasto.esIngreso, isTrue);
      expect(gasto.esGasto,   isFalse);
    });

    test('getter esGasto retorna true cuando tipo es gasto', () {
      final gasto = GastoEntity(
        id: 1, monto: 100000,
        descripcion: 'Test', fecha: DateTime.now(),
        tipo: 'gasto',
      );

      expect(gasto.esGasto, isTrue);
    });

    test('toCreateJson() genera el body correcto para POST /gastos', () {
      final gasto = GastoEntity(
        id:          0,
        monto:       85000,
        descripcion: 'Factura agua',
        fecha:       DateTime(2026, 4, 3),
        tipo:        'gasto',
        categoriaId: 3,
      );

      final json = gasto.toCreateJson();

      expect(json['categoria_id'], equals(3));
      expect(json['monto'],        equals(85000.0));
      expect(json['descripcion'],  equals('Factura agua'));
      expect(json['tipo'],         equals('gasto'));
      expect(json['fecha'],        equals('2026-04-03'));
    });
  });
}