// infrastructure/api/gasto_recurrente_api_adapter.dart
import '../../domain/entities/gasto_recurrente_entity.dart';
import '../../domain/ports/gasto_recurrente_port.dart';
import 'http_client.dart';

class GastoRecurrenteApiAdapter implements GastoRecurrentePort {
  final HttpClient _http;
  GastoRecurrenteApiAdapter(this._http);

  @override
  Future<List<GastoRecurrenteEntity>> getAll() async {
    final res = await _http.get('/gastos-recurrentes', requiresAuth: true);
    final data = res['data'] as List? ?? [];
    return data.map((e) => GastoRecurrenteEntity.fromJson(e)).toList();
  }

  @override
  Future<({GastoRecurrenteEntity regla, int generados})> create({
    required int categoriaId,
    required double monto,
    required String descripcion,
    required String tipo,
    required String frecuencia,
    required String fechaInicio,
    String? fechaFin,
  }) async {
    final res = await _http.post(
      '/gastos-recurrentes',
      {
        'categoria_id': categoriaId,
        'monto': monto,
        'descripcion': descripcion,
        'tipo': tipo,
        'frecuencia': frecuencia,
        'fecha_inicio': fechaInicio,
        if (fechaFin != null) 'fecha_fin': fechaFin,
      },
      requiresAuth: true,
    );
    return (
      regla: GastoRecurrenteEntity.fromJson(res['data'] ?? {}),
      generados: (res['generados'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  Future<GastoRecurrenteEntity> update(
      int id, Map<String, dynamic> campos) async {
    final res =
        await _http.put('/gastos-recurrentes/$id', campos, requiresAuth: true);
    return GastoRecurrenteEntity.fromJson(res['data'] ?? {});
  }

  @override
  Future<void> delete(int id) async {
    await _http.delete('/gastos-recurrentes/$id', requiresAuth: true);
  }

  @override
  Future<int> procesar() async {
    final res = await _http.post('/gastos-recurrentes/procesar', {},
        requiresAuth: true);
    return (res['generados'] as num?)?.toInt() ?? 0;
  }
}
