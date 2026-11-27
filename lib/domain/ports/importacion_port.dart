// domain/ports/importacion_port.dart
import '../entities/importacion_entity.dart';

abstract class ImportacionPort {
  /// Lee el archivo en el servidor y devuelve cada fila ya validada.
  Future<ImportPreviewEntity> previsualizar({
    required String nombreArchivo,
    required String contenidoBase64,
  });

  /// Guarda las filas aprobadas (todo o nada). Cada mapa: fecha, monto, tipo, categoria_id, descripcion.
  /// Devuelve cuántas se importaron.
  Future<int> confirmar(List<Map<String, dynamic>> filas);
}
