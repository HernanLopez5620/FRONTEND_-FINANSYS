// application/usecases/update_expense_usecase.dart
// SOLID-SRP: única responsabilidad — actualizar un gasto existente.
// Correlacionado con PUT /api/v1/gastos/:id

import '../../domain/entities/gasto_entity.dart';
import '../../domain/ports/gasto_port.dart';

class UpdateExpenseUseCase {
  final GastoPort _gastoPort;
  UpdateExpenseUseCase(this._gastoPort);

  Future<GastoEntity> execute(int id, GastoEntity gasto) {
    return _gastoPort.updateExpense(id, gasto);
  }
}
