// infrastructure/api/compra_extranjera_api_adapter.dart
import '../../domain/entities/compra_extranjera_entity.dart';
import '../../domain/ports/compra_extranjera_port.dart';
import 'http_client.dart';

class CompraExtranjeraApiAdapter implements CompraExtranjeraPort {
  final HttpClient _http;
  CompraExtranjeraApiAdapter(this._http);

  @override
  Future<List<CompraExtranjeraEntity>> getAll() async {
    final res = await _http.get('/compras-extranjeras', requiresAuth: true);
    final data = res['data'] as List? ?? [];
    return data.map((e) => CompraExtranjeraEntity.fromJson(e)).toList();
  }

  @override
  Future<CompraExtranjeraEntity> save({
    required String nombre,
    required double montoOrigen,
    required String monedaOrigen,
    required double montoCop,
    required double tasa,
  }) async {
    final res = await _http.post(
        '/compras-extranjeras',
        {
          'nombre': nombre,
          'monto_origen': montoOrigen,
          'moneda_origen': monedaOrigen,
          'monto_cop': montoCop,
          'tasa': tasa,
        },
        requiresAuth: true); // ← agregar esto
    return CompraExtranjeraEntity.fromJson(res['data'] ?? {});
  }

  @override
  Future<void> delete(int id) async {
    await _http.delete('/compras-extranjeras/$id', requiresAuth: true);
  }
}
