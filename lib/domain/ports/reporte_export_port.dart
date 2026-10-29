// domain/ports/reporte_export_port.dart
// GET /api/v1/gastos/reportes/exportar?formato=pdf|xlsx&mes=&anio=
// Devuelve el archivo (bytes) del reporte mensual del usuario autenticado.

import 'dart:typed_data';

abstract class ReporteExportPort {
  Future<Uint8List> exportar({
    required String formato,
    required int mes,
    required int anio,
  });
}
