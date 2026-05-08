// Prueba unitaria de MockGastoAdapter
// Se verifica que el adaptador mock retorna datos
// correctos para gastos, reportes y presupuestos

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/infrastructure/api/mock_gasto_adapter.dart';
import 'package:finansys/domain/entities/gasto_entity.dart';

void main() {
  group('MockGastoAdapter', () {
    late MockGastoAdapter adapter;

    setUp(() {
      adapter = MockGastoAdapter();
    });

    test('listExpenses() retorna lista no vacía', () async {
      final result = await adapter.listExpenses();

      expect(result, isNotEmpty);
    });

    test('listExpenses() retorna gastos con monto mayor a 0', () async {
      final result = await adapter.listExpenses();

      for (final g in result) {
        expect(g.monto, greaterThan(0));
      }
    });

    test('createExpense() agrega el gasto a la lista', () async {
      final antes = await adapter.listExpenses();
      final cantidadAntes = antes.length;

      await adapter.createExpense(GastoEntity(
        id:          0,
        monto:       50000,
        descripcion: 'Test gasto',
        fecha:       DateTime(2026, 4, 10),
        tipo:        'gasto',
        categoriaId: 1,
      ));

      final despues = await adapter.listExpenses();
      expect(despues.length, equals(cantidadAntes + 1));
    });

    test('deleteExpense() elimina el gasto de la lista', () async {
      final lista = await adapter.listExpenses();
      final id    = lista.first.id;
      final cantidadAntes = lista.length;

      await adapter.deleteExpense(id);

      final despues = await adapter.listExpenses();
      expect(despues.length, equals(cantidadAntes - 1));
    });

    test('getMonthSummary() retorna balance positivo', () async {
      final result = await adapter.getMonthSummary(4, 2026);

      expect(result.balance, greaterThan(0));
    });

    test('getExpensesByCategory() retorna categorías no vacías', () async {
      final result = await adapter.getExpensesByCategory(4, 2026);

      expect(result, isNotEmpty);
    });

    test('getMonthlyComparison() retorna 5 meses', () async {
      final result = await adapter.getMonthlyComparison();

      expect(result.length, equals(5));
    });
  });
}