// presentation/providers/categoria_provider.dart
// SOLID-SRP: gestiona únicamente el estado de categorías.

import 'package:flutter/foundation.dart';
import '../../domain/entities/categoria_entity.dart';
import '../../container.dart';

class CategoriaProvider extends ChangeNotifier {
  List<CategoriaEntity> _categorias = [];
  bool _loading = false;
  String? _error;

  List<CategoriaEntity> get categorias => _categorias;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadCategories() async {
    _loading = true;
    notifyListeners();
    try {
      _categorias = await Container.listCategoriesUseCase.execute();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> createCategory(CategoriaEntity categoria) async {
    try {
      final nueva = await Container.createCategoryUseCase.execute(categoria);
      _categorias.add(nueva);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
