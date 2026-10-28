// domain/ports/admin_port.dart
// GET /api/v1/admin/resumen
// GET /api/v1/admin/usuarios
// GET /api/v1/admin/logs
// Solo cuentas con rol 'admin'.

import '../entities/admin_entities.dart';

abstract class AdminPort {
  Future<AdminResumen> getResumen();

  Future<List<AdminUsuario>> getUsuarios({
    String? q,
  });

  Future<LogsPage> getLogs({
    int? uid,
    String? metodo,
    bool soloErrores = false,
    int page = 1,
    int limit = 30,
  });
}
