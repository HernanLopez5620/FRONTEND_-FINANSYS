// application/usecases/save_budget_usecase.dart
// SOLID-SRP: única responsabilidad — guardar o actualizar un presupuesto.
// Correlacionado con POST /api/v1/presupuestos (ON CONFLICT → upsert)

import '../../domain/ports/presupuesto_port.dart';

class SaveBudgetUseCase {
  final PresupuestoPort _presupuestoPort;
  SaveBudgetUseCase(this._presupuestoPort);

  Future<void> execute({
    required int categoriaId,
    required int mes,
    required int anio,
    required double montoLimite,
  }) {
    return _presupuestoPort.saveBudget(
      categoriaId: categoriaId,
      mes: mes,
      anio: anio,
      montoLimite: montoLimite,
    );
  }
}
