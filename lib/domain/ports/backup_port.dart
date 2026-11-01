// domain/ports/backup_port.dart
// GET /api/v1/users/backup
// Devuelve la copia de seguridad (JSON, sin contraseñas) del usuario autenticado.

import 'dart:typed_data';

abstract class BackupPort {
  Future<Uint8List> descargar();
}
