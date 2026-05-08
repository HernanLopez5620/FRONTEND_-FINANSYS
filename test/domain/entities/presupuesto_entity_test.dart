// Prueba unitaria de PresupuestoEntity
// Se verifica el cálculo de porcentaje y overBudget

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/presupuesto_entity.dart';

void main() {
  group('PresupuestoEntity', () {

    test('fromJson() parsea correctamente un presupuesto', () {
      final json = {
        'id':          1,
        'nombre':      'Arriendo',
        'icono':       '🏠',
        'color':       '#1A7A3C',
        'monto_limite': '1200000',
        'gastado':     '1200000',
      };

      final p = PresupuestoEntity.fromJson(json);

      expect(p.montoLimite, equals(1200000.0));
      expect(p.gastado,     equals(1200000.0));
    });

    test('porcentaje calcula correctamente', () {
      const p = PresupuestoEntity(
        id: 1, nombre: 'Test', icono: '📦',
        color: '#000', montoLimite: 500000, gastado: 250000,
      );

      expect(p.porcentaje, equals(0.5));
    });

    test('overBudget es true cuando gastado supera el límite', () {
      const p = PresupuestoEntity(
        id: 1, nombre: 'Test', icono: '📦',
        color: '#000', montoLimite: 100000, gastado: 120000,
      );

      expect(p.overBudget, isTrue);
    });

    test('overBudget es false cuando gastado es menor al límite', () {
      const p = PresupuestoEntity(
        id: 1, nombre: 'Test', icono: '📦',
        color: '#000', montoLimite: 500000, gastado: 380000,
      );

      expect(p.overBudget, isFalse);
    });

    test('porcentaje no supera 1.0 aunque se exceda el límite', () {
      const p = PresupuestoEntity(
        id: 1, nombre: 'Test', icono: '📦',
        color: '#000', montoLimite: 100000, gastado: 200000,
      );

      expect(p.porcentaje, equals(1.0));
    });
  });
}