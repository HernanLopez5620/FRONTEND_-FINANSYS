// application/usecases/get_month_summary_usecase.dart
// SOLID-SRP: única responsabilidad — obtener resumen del mes.
// Correlacionado con GET /api/v1/gastos/reportes/resumen?mes=&anio=

import '../../domain/entities/resumen_mes_entity.dart';
import '../../domain/ports/gasto_port.dart';

class GetMonthSummaryUseCase {
  final GastoPort _gastoPort;
  GetMonthSummaryUseCase(this._gastoPort);

  Future<ResumenMesEntity> execute(int mes, int anio) {
    return _gastoPort.getMonthSummary(mes, anio);
  }
}
