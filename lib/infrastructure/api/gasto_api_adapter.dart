// infrastructure/api/gasto_api_adapter.dart
// Adaptador REAL — correlacionado con gasto.routes.js y gasto.controller.js
// TODAS las rutas requieren JWT

import '../../domain/entities/gasto_entity.dart';
import '../../domain/entities/resumen_mes_entity.dart';
import '../../domain/entities/gasto_categoria_entity.dart';
import '../../domain/entities/comparacion_mensual_entity.dart';
import '../../domain/ports/gasto_port.dart';
import 'http_client.dart';

class GastoApiAdapter implements GastoPort {
  final HttpClient _http;

  GastoApiAdapter(this._http);

  String _buildQuery(Map<String, dynamic> params) {
    final parts = params.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    return parts.isNotEmpty ? '?$parts' : '';
  }

  // GET /api/v1/gastos?mes=&anio=&tipo=&limite=&pagina=
  @override
  Future<List<GastoEntity>> listExpenses({
    int? mes,
    int? anio,
    String? tipo,
    int? limite,
    int? pagina,
  }) async {
    final query = _buildQuery({
      'mes': mes,
      'anio': anio,
      'tipo': tipo,
      'limite': limite,
      'pagina': pagina,
    });
    final res = await _http.get('/gastos$query', requiresAuth: true);
    final data = res['data'] as List? ?? [];
    return data.map((e) => GastoEntity.fromJson(e)).toList();
  }

  // POST /api/v1/gastos
  @override
  Future<GastoEntity> createExpense(GastoEntity gasto) async {
    final res = await _http.post(
      '/gastos',
      gasto.toCreateJson(),
      requiresAuth: true,
    );
    return GastoEntity.fromJson(res['data'] ?? {});
  }

  // PUT /api/v1/gastos/:id
  @override
  Future<GastoEntity> updateExpense(int id, GastoEntity gasto) async {
    final res = await _http.put('/gastos/$id', gasto.toUpdateJson());
    return GastoEntity.fromJson(res['data'] ?? {});
  }

  // DELETE /api/v1/gastos/:id
  @override
  Future<void> deleteExpense(int id) async {
    await _http.delete('/gastos/$id');
  }

  // GET /api/v1/gastos/reportes/resumen?mes=&anio=
  @override
  Future<ResumenMesEntity> getMonthSummary(int mes, int anio) async {
    final res = await _http.get(
      '/gastos/reportes/resumen?mes=$mes&anio=$anio',
    );
    return ResumenMesEntity.fromJson(res['data'] ?? {});
  }

  // GET /api/v1/gastos/reportes/categorias?mes=&anio=
  @override
  Future<List<GastoCategoriaEntity>> getExpensesByCategory(
      int mes, int anio) async {
    final res = await _http.get(
      '/gastos/reportes/categorias?mes=$mes&anio=$anio',
       requiresAuth: true,
    );
    final data = res['data'] as List? ?? [];
    return data.map((e) => GastoCategoriaEntity.fromJson(e)).toList();
  }

  // GET /api/v1/gastos/reportes/comparacion
  @override
  Future<List<ComparacionMensualEntity>> getMonthlyComparison() async {
    final res = await _http.get('/gastos/reportes/comparacion',
    requiresAuth: true,);
    final data = res['data'] as List? ?? [];
    return data.map((e) => ComparacionMensualEntity.fromJson(e)).toList();
  }
}
