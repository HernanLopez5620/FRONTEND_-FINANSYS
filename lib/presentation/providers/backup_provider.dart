// presentation/providers/backup_provider.dart
// SOLID-SRP: estado de la descarga de la copia de seguridad.

import 'package:flutter/foundation.dart';
import '../../container.dart' as AppContainer;
import '../../infrastructure/files/file_saver.dart';

class BackupProvider extends ChangeNotifier {
  bool _descargando = false;
  String? _error;

  bool get descargando => _descargando;
  String? get error => _error;

  /// Descarga el archivo .json con los datos del usuario. true si se guardó.
  Future<bool> descargar() async {
    if (_descargando) return false;
    _descargando = true;
    _error = null;
    notifyListeners();
    try {
      final bytes =
          await AppContainer.Container.descargarBackupUseCase.execute();
      final h = DateTime.now();
      final fecha = '${h.year}-${h.month.toString().padLeft(2, '0')}-'
          '${h.day.toString().padLeft(2, '0')}';
      FileSaver.guardar(
          bytes, 'FinanSys_backup_$fecha.json', 'application/json');
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _descargando = false;
      notifyListeners();
    }
  }
}

