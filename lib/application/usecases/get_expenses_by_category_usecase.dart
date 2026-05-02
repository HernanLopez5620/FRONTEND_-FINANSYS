// application/usecases/get_expenses_by_category_usecase.dart
// SOLID-SRP: única responsabilidad — gastos agrupados por categoría.
// Correlacionado con GET /api/v1/gastos/reportes/categorias?mes=&anio=

import '../../domain/entities/gasto_categoria_entity.dart';
import '../../domain/ports/gasto_port.dart';

class GetExpensesByCategoryUseCase {
  final GastoPort _gastoPort;
  GetExpensesByCategoryUseCase(this._gastoPort);

  Future<List<GastoCategoriaEntity>> execute(int mes, int anio) {
    return _gastoPort.getExpensesByCategory(mes, anio);
  }
}
