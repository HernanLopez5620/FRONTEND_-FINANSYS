// application/usecases/create_expense_usecase.dart
// SOLID-SRP: única responsabilidad — crear un nuevo gasto o ingreso.
// Correlacionado con POST /api/v1/gastos

import '../../domain/entities/gasto_entity.dart';
import '../../domain/ports/gasto_port.dart';

class CreateExpenseUseCase {
  final GastoPort _gastoPort;
  CreateExpenseUseCase(this._gastoPort);

  Future<GastoEntity> execute(GastoEntity gasto) {
    return _gastoPort.createExpense(gasto);
  }
}
