// application/usecases/list_budgets_usecase.dart
// SOLID-SRP: única responsabilidad — listar presupuestos del mes.
// Correlacionado con GET /api/v1/presupuestos?mes=&anio=

import '../../domain/entities/presupuesto_entity.dart';
import '../../domain/ports/presupuesto_port.dart';

class ListBudgetsUseCase {
  final PresupuestoPort _presupuestoPort;
  ListBudgetsUseCase(this._presupuestoPort);

  Future<List<PresupuestoEntity>> execute(int mes, int anio) {
    return _presupuestoPort.listBudgets(mes, anio);
  }
}
