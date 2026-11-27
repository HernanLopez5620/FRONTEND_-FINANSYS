// infrastructure/api/importacion_api_adapter.dart
import '../../domain/entities/importacion_entity.dart';
import '../../domain/ports/importacion_port.dart';
import 'http_client.dart';

class ImportacionApiAdapter implements ImportacionPort {
  final HttpClient _http;
  ImportacionApiAdapter(this._http);

  @override
  Future<ImportPreviewEntity> previsualizar({
    required String nombreArchivo,
    required String contenidoBase64,
  }) async {
    final res = await _http.post(
      '/importar/previsualizar',
      {'nombre_archivo': nombreArchivo, 'contenido_base64': contenidoBase64},
      requiresAuth: true,
    );
    return ImportPreviewEntity.fromJson(res['data'] ?? {});
  }

  @override
  Future<int> confirmar(List<Map<String, dynamic>> filas) async {
    final res = await _http.post('/importar/confirmar', {'filas': filas},
        requiresAuth: true);
    final data = res['data'] as Map<String, dynamic>? ?? {};
    return (data['importados'] as num?)?.toInt() ?? 0;
  }
}
