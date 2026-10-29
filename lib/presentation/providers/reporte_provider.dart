// presentation/providers/reporte_provider.dart
// SOLID-SRP: estado de la exportación de reportes (PDF / Excel).

import 'package:flutter/foundation.dart';
import '../../container.dart';
import '../../infrastructure/files/file_saver.dart';

class ReporteProvider extends ChangeNotifier {
  static const _mimes = {
    'pdf': 'application/pdf',
    'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  };

  bool _exportando = false;
  String? _error;

  bool get exportando => _exportando;
  String? get error => _error;

  /// Descarga el reporte del mes indicado. Devuelve true si el archivo se guardó.
  Future<bool> exportar({
    required String formato,
    required int mes,
    required int anio,
  }) async {
    if (_exportando) return false;
    _exportando = true;
    _error = null;
    notifyListeners();
    try {
      final bytes = await Container.exportarReporteUseCase
          .execute(formato: formato, mes: mes, anio: anio);
      final nombre =
          'FinanSys_reporte_$anio-${mes.toString().padLeft(2, '0')}.$formato';
      FileSaver.guardar(bytes, nombre, _mimes[formato]!);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _exportando = false;
      notifyListeners();
    }
  }
}
