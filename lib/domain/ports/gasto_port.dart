// domain/ports/gasto_port.dart
// GET    /api/v1/gastos?mes=&anio=&tipo=&limite=&pagina=
// POST   /api/v1/gastos
// PUT    /api/v1/gastos/:id
// DELETE /api/v1/gastos/:id
// GET    /api/v1/gastos/reportes/resumen?mes=&anio=
// GET    /api/v1/gastos/reportes/categorias?mes=&anio=
// GET    /api/v1/gastos/reportes/comparacion

import '../entities/gasto_entity.dart';
import '../entities/resumen_mes_entity.dart';
import '../entities/gasto_categoria_entity.dart';
import '../entities/comparacion_mensual_entity.dart';

abstract class GastoPort {
  Future<List<GastoEntity>> listExpenses({
    int? mes,
    int? anio,
    String? tipo,
    int? limite,
    int? pagina,
  });
  Future<GastoEntity> createExpense(GastoEntity gasto);
  Future<GastoEntity> updateExpense(int id, GastoEntity gasto);
  Future<void> deleteExpense(int id);
  Future<ResumenMesEntity> getMonthSummary(int mes, int anio);
  Future<List<GastoCategoriaEntity>> getExpensesByCategory(int mes, int anio);
  Future<List<ComparacionMensualEntity>> getMonthlyComparison();
}
