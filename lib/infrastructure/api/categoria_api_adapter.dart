// infrastructure/api/categoria_api_adapter.dart
// Adaptador REAL — correlacionado con categoria.routes.js

import '../../domain/entities/categoria_entity.dart';
import '../../domain/ports/categoria_port.dart';
import 'http_client.dart';

class CategoriaApiAdapter implements CategoriaPort {
  final HttpClient _http;

  CategoriaApiAdapter(this._http);

  // GET /api/v1/categorias
  @override
  Future<List<CategoriaEntity>> listCategories() async {
    final res = await _http.get('/categorias',
    requiresAuth: true,);
    final data = res['data'] as List? ?? [];
    return data.map((e) => CategoriaEntity.fromJson(e)).toList();
  }

  // POST /api/v1/categorias
  // Body: { nombre, icono, color, tipo }
  @override
  Future<CategoriaEntity> createCategory(CategoriaEntity categoria) async {
    final res = await _http.post(
      '/categorias',
      categoria.toJson(),
      requiresAuth: true,
    );
    return CategoriaEntity.fromJson(res['data'] ?? {});
  }
}
