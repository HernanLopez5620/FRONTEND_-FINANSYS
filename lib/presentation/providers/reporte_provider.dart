// presentation/providers/reporte_provider.dart
// SOLID-SRP: estado de la exportación de reportes (PDF / Excel).

import 'package:flutter/foundation.dart';
import '../../container.dart';
import '../../infrastructure/files/file_saver.dart';
import '../errors/error_translator.dart';

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
    required String idioma, // 'es' | 'en'
    required String prefijoArchivo, // p. ej. FinanSys_reporte / FinanSys_report
  }) async {
    if (_exportando) return false;
    _exportando = true;
    _error = null;
    notifyListeners();
    try {
      final bytes = await Container.exportarReporteUseCase
          .execute(formato: formato, mes: mes, anio: anio, locale: idioma);
      final nombre =
          '${prefijoArchivo}_$anio-${mes.toString().padLeft(2, '0')}.$formato';
      FileSaver.guardar(bytes, nombre, _mimes[formato]!);
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      return false;
    } finally {
      _exportando = false;
      notifyListeners();
    }
  }
}
