// domain/ports/categoria_port.dart
// GET  /api/v1/categorias
// POST /api/v1/categorias

import '../entities/categoria_entity.dart';

abstract class CategoriaPort {
  Future<List<CategoriaEntity>> listCategories();
  Future<CategoriaEntity> createCategory(CategoriaEntity categoria);
}
