// application/usecases/gasto_recurrente_usecases.dart
import '../../domain/entities/gasto_recurrente_entity.dart';
import '../../domain/ports/gasto_recurrente_port.dart';

class ListarGastosRecurrentesUseCase {
  final GastoRecurrentePort _port;
  ListarGastosRecurrentesUseCase(this._port);
  Future<List<GastoRecurrenteEntity>> execute() => _port.getAll();
}

class CrearGastoRecurrenteUseCase {
  final GastoRecurrentePort _port;
  CrearGastoRecurrenteUseCase(this._port);
  Future<({GastoRecurrenteEntity regla, int generados})> execute({
    required int categoriaId,
    required double monto,
    required String descripcion,
    required String tipo,
    required String frecuencia,
    required String fechaInicio,
    String? fechaFin,
  }) =>
      _port.create(
        categoriaId: categoriaId,
        monto: monto,
        descripcion: descripcion,
        tipo: tipo,
        frecuencia: frecuencia,
        fechaInicio: fechaInicio,
        fechaFin: fechaFin,
      );
}

class ActualizarGastoRecurrenteUseCase {
  final GastoRecurrentePort _port;
  ActualizarGastoRecurrenteUseCase(this._port);
  Future<GastoRecurrenteEntity> execute(int id, Map<String, dynamic> campos) =>
      _port.update(id, campos);
}

class EliminarGastoRecurrenteUseCase {
  final GastoRecurrentePort _port;
  EliminarGastoRecurrenteUseCase(this._port);
  Future<void> execute(int id) => _port.delete(id);
}

class ProcesarGastosRecurrentesUseCase {
  final GastoRecurrentePort _port;
  ProcesarGastosRecurrentesUseCase(this._port);
  Future<int> execute() => _port.procesar();
}
