// application/usecases/get_monthly_comparison_usecase.dart
// SOLID-SRP: única responsabilidad — comparativa de los últimos 6 meses.
// Correlacionado con GET /api/v1/gastos/reportes/comparacion

import '../../domain/entities/comparacion_mensual_entity.dart';
import '../../domain/ports/gasto_port.dart';

class GetMonthlyComparisonUseCase {
  final GastoPort _gastoPort;
  GetMonthlyComparisonUseCase(this._gastoPort);

  Future<List<ComparacionMensualEntity>> execute() {
    return _gastoPort.getMonthlyComparison();
  }
}
