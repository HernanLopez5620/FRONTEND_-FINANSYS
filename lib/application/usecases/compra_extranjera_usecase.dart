// application/usecases/compra_extranjera_usecase.dart
import '../../domain/entities/compra_extranjera_entity.dart';
import '../../domain/ports/compra_extranjera_port.dart';

class ListarComprasUseCase {
  final CompraExtranjeraPort _port;
  ListarComprasUseCase(this._port);
  Future<List<CompraExtranjeraEntity>> execute() => _port.getAll();
}

class GuardarCompraUseCase {
  final CompraExtranjeraPort _port;
  GuardarCompraUseCase(this._port);
  Future<CompraExtranjeraEntity> execute({
    required String nombre,
    required double montoOrigen,
    required String monedaOrigen,
    required double montoCop,
    required double tasa,
  }) =>
      _port.save(
        nombre: nombre,
        montoOrigen: montoOrigen,
        monedaOrigen: monedaOrigen,
        montoCop: montoCop,
        tasa: tasa,
      );
}

class EliminarCompraUseCase {
  final CompraExtranjeraPort _port;
  EliminarCompraUseCase(this._port);
  Future<void> execute(int id) => _port.delete(id);
}
