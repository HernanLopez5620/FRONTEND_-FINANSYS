// application/usecases/meta_ahorro_usecases.dart
import '../../domain/entities/meta_ahorro_entity.dart';
import '../../domain/ports/meta_ahorro_port.dart';

class ListarMetasUseCase {
  final MetaAhorroPort _port;
  ListarMetasUseCase(this._port);
  Future<List<MetaAhorroEntity>> execute() => _port.getAll();
}

class CrearMetaUseCase {
  final MetaAhorroPort _port;
  CrearMetaUseCase(this._port);
  Future<MetaAhorroEntity> execute({
    required String nombre,
    required String icono,
    required double montoObjetivo,
    String? fechaLimite,
  }) =>
      _port.create(
        nombre: nombre,
        icono: icono,
        montoObjetivo: montoObjetivo,
        fechaLimite: fechaLimite,
      );
}

class ActualizarMetaUseCase {
  final MetaAhorroPort _port;
  ActualizarMetaUseCase(this._port);
  Future<MetaAhorroEntity> execute(int id, Map<String, dynamic> campos) =>
      _port.update(id, campos);
}

class EliminarMetaUseCase {
  final MetaAhorroPort _port;
  EliminarMetaUseCase(this._port);
  Future<void> execute(int id) => _port.delete(id);
}

class RegistrarAporteMetaUseCase {
  final MetaAhorroPort _port;
  RegistrarAporteMetaUseCase(this._port);
  Future<MetaAhorroEntity> execute(
    int metaId, {
    required double monto,
    required String tipo,
    String nota = '',
  }) =>
      _port.registrarAporte(metaId, monto: monto, tipo: tipo, nota: nota);
}

class ListarAportesMetaUseCase {
  final MetaAhorroPort _port;
  ListarAportesMetaUseCase(this._port);
  Future<List<AporteMetaEntity>> execute(int metaId) =>
      _port.getAportes(metaId);
}

class EliminarAporteMetaUseCase {
  final MetaAhorroPort _port;
  EliminarAporteMetaUseCase(this._port);
  Future<MetaAhorroEntity> execute(int metaId, int aporteId) =>
      _port.deleteAporte(metaId, aporteId);
}
