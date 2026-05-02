// domain/ports/presupuesto_port.dart
// GET  /api/v1/presupuestos?mes=&anio=
// POST /api/v1/presupuestos  (upsert con ON CONFLICT)

import '../entities/presupuesto_entity.dart';

abstract class PresupuestoPort {
  Future<List<PresupuestoEntity>> listBudgets(int mes, int anio);
  Future<void> saveBudget({
    required int categoriaId,
    required int mes,
    required int anio,
    required double montoLimite,
  });
}
