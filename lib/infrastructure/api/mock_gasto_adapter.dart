// infrastructure/api/mock_gasto_adapter.dart
// Adaptador MOCK de gastos — datos de prueba realistas en COP.

import '../../domain/entities/gasto_entity.dart';
import '../../domain/entities/resumen_mes_entity.dart';
import '../../domain/entities/gasto_categoria_entity.dart';
import '../../domain/entities/comparacion_mensual_entity.dart';
import '../../domain/ports/gasto_port.dart';

class MockGastoAdapter implements GastoPort {
  final List<GastoEntity> _gastos = [
    GastoEntity(
        id: 1,
        monto: 1200000,
        descripcion: 'Arriendo abril',
        fecha: DateTime(2026, 4, 1),
        tipo: 'gasto',
        categoriaId: 1,
        categoria: 'Arriendo',
        icono: '🏠',
        color: '#1A7A3C'),
    GastoEntity(
        id: 2,
        monto: 142000,
        descripcion: 'Factura de luz',
        fecha: DateTime(2026, 4, 2),
        tipo: 'gasto',
        categoriaId: 2,
        categoria: 'Luz',
        icono: '⚡',
        color: '#E67E22'),
    GastoEntity(
        id: 3,
        monto: 85000,
        descripcion: 'Factura agua',
        fecha: DateTime(2026, 4, 3),
        tipo: 'gasto',
        categoriaId: 3,
        categoria: 'Agua',
        icono: '💧',
        color: '#3498DB'),
    GastoEntity(
        id: 4,
        monto: 89000,
        descripcion: 'Internet fibra',
        fecha: DateTime(2026, 4, 3),
        tipo: 'gasto',
        categoriaId: 4,
        categoria: 'Internet',
        icono: '🌐',
        color: '#9B59B6'),
    GastoEntity(
        id: 5,
        monto: 65000,
        descripcion: 'Plan celular',
        fecha: DateTime(2026, 4, 4),
        tipo: 'gasto',
        categoriaId: 5,
        categoria: 'Teléfono',
        icono: '📱',
        color: '#1ABC9C'),
    GastoEntity(
        id: 6,
        monto: 5800000,
        descripcion: 'Salario abril',
        fecha: DateTime(2026, 4, 1),
        tipo: 'ingreso',
        categoriaId: 6,
        categoria: 'Salario',
        icono: '💼',
        color: '#27AE60'),
    GastoEntity(
        id: 7,
        monto: 380000,
        descripcion: 'Mercado semana',
        fecha: DateTime(2026, 4, 5),
        tipo: 'gasto',
        categoriaId: 7,
        categoria: 'Mercado',
        icono: '🛒',
        color: '#E74C3C'),
    GastoEntity(
        id: 8,
        monto: 120000,
        descripcion: 'Transporte mes',
        fecha: DateTime(2026, 4, 6),
        tipo: 'gasto',
        categoriaId: 8,
        categoria: 'Transporte',
        icono: '🚌',
        color: '#F39C12'),
  ];

  @override
  Future<List<GastoEntity>> listExpenses({
    int? mes,
    int? anio,
    String? tipo,
    int? limite,
    int? pagina,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var result = List<GastoEntity>.from(_gastos);
    if (tipo != null) result = result.where((g) => g.tipo == tipo).toList();
    return result;
  }

  @override
  Future<GastoEntity> createExpense(GastoEntity gasto) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final nuevo = GastoEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      monto: gasto.monto,
      descripcion: gasto.descripcion,
      fecha: gasto.fecha,
      tipo: gasto.tipo,
      categoriaId: gasto.categoriaId,
      categoria: gasto.categoria,
      icono: gasto.icono,
      color: gasto.color,
    );
    _gastos.insert(0, nuevo);
    return nuevo;
  }

  @override
  Future<GastoEntity> updateExpense(int id, GastoEntity gasto) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final idx = _gastos.indexWhere((g) => g.id == id);
    if (idx != -1) _gastos[idx] = gasto;
    return gasto;
  }

  @override
  Future<void> deleteExpense(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _gastos.removeWhere((g) => g.id == id);
  }

  @override
  Future<ResumenMesEntity> getMonthSummary(int mes, int anio) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const ResumenMesEntity(
      ingresos: 5800000,
      gastos: 2081000,
      balance: 3719000,
    );
  }

  @override
  Future<List<GastoCategoriaEntity>> getExpensesByCategory(
      int mes, int anio) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      GastoCategoriaEntity(
          nombre: 'Arriendo', icono: '🏠', color: '#1A7A3C', total: 1200000),
      GastoCategoriaEntity(
          nombre: 'Mercado', icono: '🛒', color: '#E74C3C', total: 380000),
      GastoCategoriaEntity(
          nombre: 'Luz', icono: '⚡', color: '#E67E22', total: 142000),
      GastoCategoriaEntity(
          nombre: 'Transporte', icono: '🚌', color: '#F39C12', total: 120000),
      GastoCategoriaEntity(
          nombre: 'Internet', icono: '🌐', color: '#9B59B6', total: 89000),
      GastoCategoriaEntity(
          nombre: 'Agua', icono: '💧', color: '#3498DB', total: 85000),
    ];
  }

  @override
  Future<List<ComparacionMensualEntity>> getMonthlyComparison() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      ComparacionMensualEntity(
          anio: 2025, mes: 12, ingresos: 5200000, gastos: 2180000),
      ComparacionMensualEntity(
          anio: 2026, mes: 1, ingresos: 5200000, gastos: 2490000),
      ComparacionMensualEntity(
          anio: 2026, mes: 2, ingresos: 5500000, gastos: 2270000),
      ComparacionMensualEntity(
          anio: 2026, mes: 3, ingresos: 5500000, gastos: 2640000),
      ComparacionMensualEntity(
          anio: 2026, mes: 4, ingresos: 5800000, gastos: 2081000),
    ];
  }
}
