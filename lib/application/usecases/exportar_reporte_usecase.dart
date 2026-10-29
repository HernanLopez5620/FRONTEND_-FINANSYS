// application/usecases/exportar_reporte_usecase.dart
// SOLID-SRP: única responsabilidad — pedir el reporte mensual en PDF o Excel.

import 'dart:typed_data';
import '../../core/errors/app_errors.dart';
import '../../domain/ports/reporte_export_port.dart';

class ExportarReporteUseCase {
  final ReporteExportPort _port;
  ExportarReporteUseCase(this._port);

  Future<Uint8List> execute({
    required String formato,
    required int mes,
    required int anio,
  }) {
    if (formato != 'pdf' && formato != 'xlsx') {
      throw const ValidationError("Formato no soportado: usa 'pdf' o 'xlsx'");
    }
    return _port.exportar(formato: formato, mes: mes, anio: anio);
  }
}
