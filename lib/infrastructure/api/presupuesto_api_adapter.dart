// infrastructure/api/presupuesto_api_adapter.dart
// Adaptador REAL — correlacionado con presupuesto.routes.js

import '../../domain/entities/presupuesto_entity.dart';
import '../../domain/ports/presupuesto_port.dart';
import 'http_client.dart';

class PresupuestoApiAdapter implements PresupuestoPort {
  final HttpClient _http;

  PresupuestoApiAdapter(this._http);

  // GET /api/v1/presupuestos?mes=&anio=
  @override
  Future<List<PresupuestoEntity>> listBudgets(int mes, int anio) async {
    final res = await _http.get('/presupuestos?mes=$mes&anio=$anio');
    final data = res['data'] as List? ?? [];
    return data.map((e) => PresupuestoEntity.fromJson(e)).toList();
  }

  // POST /api/v1/presupuestos
  // Body: { categoria_id, mes, anio, monto_limite }
  // Usa ON CONFLICT → upsert si ya existe
  @override
  Future<void> saveBudget({
    required int categoriaId,
    required int mes,
    required int anio,
    required double montoLimite,
  }) async {
    await _http.post(
      '/presupuestos',
      {
        'categoria_id': categoriaId,
        'mes': mes,
        'anio': anio,
        'monto_limite': montoLimite,
      },
      requiresAuth: true,
    );
  }
}
