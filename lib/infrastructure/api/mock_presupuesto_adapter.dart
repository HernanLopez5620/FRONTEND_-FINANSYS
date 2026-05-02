// infrastructure/api/mock_presupuesto_adapter.dart

import '../../domain/entities/presupuesto_entity.dart';
import '../../domain/ports/presupuesto_port.dart';

class MockPresupuestoAdapter implements PresupuestoPort {
  @override
  Future<List<PresupuestoEntity>> listBudgets(int mes, int anio) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      PresupuestoEntity(
          id: 1,
          nombre: 'Arriendo',
          icono: '🏠',
          color: '#1A7A3C',
          montoLimite: 1200000,
          gastado: 1200000),
      PresupuestoEntity(
          id: 2,
          nombre: 'Mercado',
          icono: '🛒',
          color: '#E74C3C',
          montoLimite: 500000,
          gastado: 380000),
      PresupuestoEntity(
          id: 3,
          nombre: 'Luz',
          icono: '⚡',
          color: '#E67E22',
          montoLimite: 160000,
          gastado: 142000),
      PresupuestoEntity(
          id: 4,
          nombre: 'Transporte',
          icono: '🚌',
          color: '#F39C12',
          montoLimite: 200000,
          gastado: 120000),
      PresupuestoEntity(
          id: 5,
          nombre: 'Internet',
          icono: '🌐',
          color: '#9B59B6',
          montoLimite: 100000,
          gastado: 89000),
    ];
  }

  @override
  Future<void> saveBudget({
    required int categoriaId,
    required int mes,
    required int anio,
    required double montoLimite,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
