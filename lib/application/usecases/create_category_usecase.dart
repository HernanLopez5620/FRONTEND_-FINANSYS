// application/usecases/create_category_usecase.dart
// SOLID-SRP: única responsabilidad — crear una nueva categoría.
// Correlacionado con POST /api/v1/categorias

import '../../domain/entities/categoria_entity.dart';
import '../../domain/ports/categoria_port.dart';

class CreateCategoryUseCase {
  final CategoriaPort _categoriaPort;
  CreateCategoryUseCase(this._categoriaPort);

  Future<CategoriaEntity> execute(CategoriaEntity categoria) {
    return _categoriaPort.createCategory(categoria);
  }
}
