// presentation/providers/presupuesto_provider.dart
// SOLID-SRP: gestiona únicamente el estado de presupuestos.

import 'package:flutter/foundation.dart';
import '../../domain/entities/presupuesto_entity.dart';
import '../../container.dart';

class PresupuestoProvider extends ChangeNotifier {
  List<PresupuestoEntity> _presupuestos = [];
  bool _loading = false;
  String? _error;

  List<PresupuestoEntity> get presupuestos => _presupuestos;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadBudgets(int mes, int anio) async {
    _loading = true;
    notifyListeners();
    try {
      _presupuestos = await Container.listBudgetsUseCase.execute(mes, anio);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> saveBudget({
    required int categoriaId,
    required int mes,
    required int anio,
    required double montoLimite,
  }) async {
    try {
      await Container.saveBudgetUseCase.execute(
        categoriaId: categoriaId,
        mes: mes,
        anio: anio,
        montoLimite: montoLimite,
      );
      await loadBudgets(mes, anio);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
