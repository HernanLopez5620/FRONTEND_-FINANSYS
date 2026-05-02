// application/usecases/list_expenses_usecase.dart
// SOLID-SRP: única responsabilidad — listar gastos con filtros opcionales.
// Correlacionado con GET /api/v1/gastos?mes=&anio=&tipo=&limite=&pagina=

import '../../domain/entities/gasto_entity.dart';
import '../../domain/ports/gasto_port.dart';

class ListExpensesUseCase {
  final GastoPort _gastoPort;
  ListExpensesUseCase(this._gastoPort);

  Future<List<GastoEntity>> execute({
    int? mes,
    int? anio,
    String? tipo,
    int? limite,
    int? pagina,
  }) {
    return _gastoPort.listExpenses(
      mes: mes,
      anio: anio,
      tipo: tipo,
      limite: limite,
      pagina: pagina,
    );
  }
}
