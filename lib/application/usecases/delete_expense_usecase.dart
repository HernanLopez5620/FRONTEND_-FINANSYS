// application/usecases/delete_expense_usecase.dart
// SOLID-SRP: única responsabilidad — eliminar un gasto.
// Correlacionado con DELETE /api/v1/gastos/:id

import '../../domain/ports/gasto_port.dart';

class DeleteExpenseUseCase {
  final GastoPort _gastoPort;
  DeleteExpenseUseCase(this._gastoPort);

  Future<void> execute(int id) => _gastoPort.deleteExpense(id);
}
