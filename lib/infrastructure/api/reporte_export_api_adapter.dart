// infrastructure/api/reporte_export_api_adapter.dart
// Adaptador REAL — descarga el reporte desde el backend.

import 'dart:typed_data';
import '../../domain/ports/reporte_export_port.dart';
import 'http_client.dart';

class ReporteExportApiAdapter implements ReporteExportPort {
  final HttpClient _http;
  ReporteExportApiAdapter(this._http);

  @override
  Future<Uint8List> exportar({
    required String formato,
    required int mes,
    required int anio,
  }) {
    return _http.getBytes(
      '/gastos/reportes/exportar?formato=$formato&mes=$mes&anio=$anio',
    );
  }
}
