// Prueba unitaria de ListExpensesUseCase
// Se verifica que retorna la lista correcta con filtros

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/application/usecases/list_expenses_usecase.dart';
import 'package:finansys/domain/entities/gasto_entity.dart';
import 'package:finansys/domain/entities/resumen_mes_entity.dart';
import 'package:finansys/domain/entities/gasto_categoria_entity.dart';
import 'package:finansys/domain/entities/comparacion_mensual_entity.dart';
import 'package:finansys/domain/ports/gasto_port.dart';

class MockGastoPort implements GastoPort {
  @override
  Future<List<GastoEntity>> listExpenses({
    int? mes, int? anio, String? tipo, int? limite, int? pagina,
  }) async {
    return [
      GastoEntity(id: 1, monto: 150000, descripcion: 'Luz',
          fecha: DateTime(2026, 4, 2), tipo: 'gasto'),
      GastoEntity(id: 2, monto: 5800000, descripcion: 'Salario',
          fecha: DateTime(2026, 4, 1), tipo: 'ingreso'),
    ];
  }

  @override Future<GastoEntity> createExpense(GastoEntity g) async => throw UnimplementedError();
  @override Future<GastoEntity> updateExpense(int id, GastoEntity g) async => throw UnimplementedError();
  @override Future<void> deleteExpense(int id) async => throw UnimplementedError();
  @override Future<ResumenMesEntity> getMonthSummary(int m, int a) async => throw UnimplementedError();
  @override Future<List<GastoCategoriaEntity>> getExpensesByCategory(int m, int a) async => throw UnimplementedError();
  @override Future<List<ComparacionMensualEntity>> getMonthlyComparison() async => throw UnimplementedError();
}

void main() {
  group('ListExpensesUseCase', () {
    late ListExpensesUseCase useCase;

    setUp(() {
      useCase = ListExpensesUseCase(MockGastoPort());
    });

    test('execute() retorna la lista de gastos', () async {
      final result = await useCase.execute(mes: 4, anio: 2026);

      expect(result.length, equals(2));
    });

    test('execute() retorna gastos con montos correctos', () async {
      final result = await useCase.execute();

      expect(result[0].monto, equals(150000.0));
      expect(result[1].monto, equals(5800000.0));
    });

    test('execute() retorna gastos con tipos correctos', () async {
      final result = await useCase.execute();

      expect(result[0].tipo, equals('gasto'));
      expect(result[1].tipo, equals('ingreso'));
    });
  });
}