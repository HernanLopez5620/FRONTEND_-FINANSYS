// Prueba unitaria de ResumenMesEntity
// Se verifica que fromJson() parsea los datos del reporte
// y que savingsPercent calcula correctamente

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/resumen_mes_entity.dart';

void main() {
  group('ResumenMesEntity', () {

    test('fromJson() parsea correctamente el resumen del mes', () {
      final json = {
        'ingresos': '5800000',
        'gastos':   '2081000',
        'balance':  '3719000',
      };

      final r = ResumenMesEntity.fromJson(json);

      expect(r.ingresos, equals(5800000.0));
      expect(r.gastos,   equals(2081000.0));
      expect(r.balance,  equals(3719000.0));
    });

    test('savingsPercent calcula correctamente el porcentaje de ahorro', () {
      const r = ResumenMesEntity(
        ingresos: 5800000,
        gastos:   2081000,
        balance:  3719000,
      );

      expect(r.savingsPercent.toStringAsFixed(1), equals('64.1'));
    });

    test('savingsPercent retorna 0 cuando no hay ingresos', () {
      const r = ResumenMesEntity(
        ingresos: 0,
        gastos:   0,
        balance:  0,
      );

      expect(r.savingsPercent, equals(0));
    });

    test('fromJson() usa 0 si faltan campos', () {
      final r = ResumenMesEntity.fromJson({});

      expect(r.ingresos, equals(0.0));
      expect(r.gastos,   equals(0.0));
      expect(r.balance,  equals(0.0));
    });
  });
}