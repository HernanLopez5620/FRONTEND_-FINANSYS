// application/usecases/list_categories_usecase.dart
// SOLID-SRP: única responsabilidad — listar categorías del usuario.
// Correlacionado con GET /api/v1/categorias

import '../../domain/entities/categoria_entity.dart';
import '../../domain/ports/categoria_port.dart';

class ListCategoriesUseCase {
  final CategoriaPort _categoriaPort;
  ListCategoriesUseCase(this._categoriaPort);

  Future<List<CategoriaEntity>> execute() {
    return _categoriaPort.listCategories();
  }
}
