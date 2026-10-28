// application/usecases/admin_usecases.dart
// Casos de uso del panel de administrador (solo lectura).

import '../../domain/entities/admin_entities.dart';
import '../../domain/ports/admin_port.dart';

class ResumenAdminUseCase {
  final AdminPort _port;

  ResumenAdminUseCase(this._port);

  Future<AdminResumen> execute() {
    return _port.getResumen();
  }
}

class ListarUsuariosAdminUseCase {
  final AdminPort _port;

  ListarUsuariosAdminUseCase(this._port);

  Future<List<AdminUsuario>> execute({
    String? q,
  }) {
    return _port.getUsuarios(q: q);
  }
}

class ListarLogsAdminUseCase {
  final AdminPort _port;

  ListarLogsAdminUseCase(this._port);

  Future<LogsPage> execute({
    int? uid,
    String? metodo,
    bool soloErrores = false,
    int page = 1,
    int limit = 30,
  }) {
    return _port.getLogs(
      uid: uid,
      metodo: metodo,
      soloErrores: soloErrores,
      page: page,
      limit: limit,
    );
  }
}
