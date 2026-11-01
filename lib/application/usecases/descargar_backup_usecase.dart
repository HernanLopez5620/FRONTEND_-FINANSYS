// application/usecases/descargar_backup_usecase.dart
// SOLID-SRP: única responsabilidad — pedir la copia de seguridad del usuario.

import 'dart:typed_data';
import '../../domain/ports/backup_port.dart';

class DescargarBackupUseCase {
  final BackupPort _port;
  DescargarBackupUseCase(this._port);

  Future<Uint8List> execute() => _port.descargar();
}

