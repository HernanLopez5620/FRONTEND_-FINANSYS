// Prueba unitaria de ComparacionMensualEntity
// Se verifica el cálculo de balance y la etiqueta del mes

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/comparacion_mensual_entity.dart';

void main() {
  group('ComparacionMensualEntity', () {

    test('fromJson() parsea correctamente la comparación mensual', () {
      final json = {
        'anio':     2026.0,
        'mes':      4.0,
        'ingresos': '5800000',
        'gastos':   '2081000',
      };

      final c = ComparacionMensualEntity.fromJson(json);

      expect(c.anio,     equals(2026));
      expect(c.mes,      equals(4));
      expect(c.ingresos, equals(5800000.0));
      expect(c.gastos,   equals(2081000.0));
    });

    test('balance calcula correctamente ingresos menos gastos', () {
      const c = ComparacionMensualEntity(
        anio: 2026, mes: 4,
        ingresos: 5800000, gastos: 2081000,
      );

      expect(c.balance, equals(3719000.0));
    });

    test('mesLabel retorna la etiqueta correcta del mes', () {
      const c = ComparacionMensualEntity(
        anio: 2026, mes: 4,
        ingresos: 0, gastos: 0,
      );

      expect(c.mesLabel, equals('Abr'));
    });

    test('mesLabel para diciembre retorna Dic', () {
      const c = ComparacionMensualEntity(
        anio: 2025, mes: 12,
        ingresos: 0, gastos: 0,
      );

      expect(c.mesLabel, equals('Dic'));
    });
  });
}