// infrastructure/api/meta_ahorro_api_adapter.dart
import '../../domain/entities/meta_ahorro_entity.dart';
import '../../domain/ports/meta_ahorro_port.dart';
import 'http_client.dart';

class MetaAhorroApiAdapter implements MetaAhorroPort {
  final HttpClient _http;
  MetaAhorroApiAdapter(this._http);

  @override
  Future<List<MetaAhorroEntity>> getAll() async {
    final res = await _http.get('/metas-ahorro', requiresAuth: true);
    final data = res['data'] as List? ?? [];
    return data.map((e) => MetaAhorroEntity.fromJson(e)).toList();
  }

  @override
  Future<MetaAhorroEntity> create({
    required String nombre,
    required String icono,
    required double montoObjetivo,
    String? fechaLimite,
  }) async {
    final res = await _http.post(
      '/metas-ahorro',
      {
        'nombre': nombre,
        'icono': icono,
        'monto_objetivo': montoObjetivo,
        if (fechaLimite != null) 'fecha_limite': fechaLimite,
      },
      requiresAuth: true,
    );
    return MetaAhorroEntity.fromJson(res['data'] ?? {});
  }

  @override
  Future<MetaAhorroEntity> update(int id, Map<String, dynamic> campos) async {
    final res =
        await _http.put('/metas-ahorro/$id', campos, requiresAuth: true);
    return MetaAhorroEntity.fromJson(res['data'] ?? {});
  }

  @override
  Future<void> delete(int id) async {
    await _http.delete('/metas-ahorro/$id', requiresAuth: true);
  }

  @override
  Future<MetaAhorroEntity> registrarAporte(
    int metaId, {
    required double monto,
    required String tipo,
    String nota = '',
  }) async {
    final res = await _http.post(
      '/metas-ahorro/$metaId/aportes',
      {'monto': monto, 'tipo': tipo, 'nota': nota},
      requiresAuth: true,
    );
    return MetaAhorroEntity.fromJson(res['data'] ?? {});
  }

  @override
  Future<List<AporteMetaEntity>> getAportes(int metaId) async {
    final res =
        await _http.get('/metas-ahorro/$metaId/aportes', requiresAuth: true);
    final data = res['data'] as List? ?? [];
    return data.map((e) => AporteMetaEntity.fromJson(e)).toList();
  }

  @override
  Future<MetaAhorroEntity> deleteAporte(int metaId, int aporteId) async {
    final res = await _http.delete('/metas-ahorro/$metaId/aportes/$aporteId',
        requiresAuth: true);
    return MetaAhorroEntity.fromJson(res['data'] ?? {});
  }
}
