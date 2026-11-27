// application/usecases/importacion_usecases.dart
import '../../domain/entities/importacion_entity.dart';
import '../../domain/ports/importacion_port.dart';

class PrevisualizarImportacionUseCase {
  final ImportacionPort _port;
  PrevisualizarImportacionUseCase(this._port);
  Future<ImportPreviewEntity> execute({
    required String nombreArchivo,
    required String contenidoBase64,
  }) =>
      _port.previsualizar(
          nombreArchivo: nombreArchivo, contenidoBase64: contenidoBase64);
}

class ConfirmarImportacionUseCase {
  final ImportacionPort _port;
  ConfirmarImportacionUseCase(this._port);
  Future<int> execute(List<Map<String, dynamic>> filas) =>
      _port.confirmar(filas);
}
