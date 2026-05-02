// infrastructure/api/mock_categoria_adapter.dart

import '../../domain/entities/categoria_entity.dart';
import '../../domain/ports/categoria_port.dart';

class MockCategoriaAdapter implements CategoriaPort {
  final List<CategoriaEntity> _categorias = [
    const CategoriaEntity(
        id: 1,
        nombre: 'Arriendo',
        icono: '🏠',
        color: '#1A7A3C',
        tipo: 'gasto'),
    const CategoriaEntity(
        id: 2, nombre: 'Luz', icono: '⚡', color: '#E67E22', tipo: 'gasto'),
    const CategoriaEntity(
        id: 3, nombre: 'Agua', icono: '💧', color: '#3498DB', tipo: 'gasto'),
    const CategoriaEntity(
        id: 4,
        nombre: 'Internet',
        icono: '🌐',
        color: '#9B59B6',
        tipo: 'gasto'),
    const CategoriaEntity(
        id: 5,
        nombre: 'Teléfono',
        icono: '📱',
        color: '#1ABC9C',
        tipo: 'gasto'),
    const CategoriaEntity(
        id: 6,
        nombre: 'Salario',
        icono: '💼',
        color: '#27AE60',
        tipo: 'ingreso'),
    const CategoriaEntity(
        id: 7, nombre: 'Mercado', icono: '🛒', color: '#E74C3C', tipo: 'gasto'),
    const CategoriaEntity(
        id: 8,
        nombre: 'Transporte',
        icono: '🚌',
        color: '#F39C12',
        tipo: 'gasto'),
  ];

  @override
  Future<List<CategoriaEntity>> listCategories() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.from(_categorias);
  }

  @override
  Future<CategoriaEntity> createCategory(CategoriaEntity categoria) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final nueva = CategoriaEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: categoria.nombre,
      icono: categoria.icono,
      color: categoria.color,
      tipo: categoria.tipo,
    );
    _categorias.add(nueva);
    return nueva;
  }
}
