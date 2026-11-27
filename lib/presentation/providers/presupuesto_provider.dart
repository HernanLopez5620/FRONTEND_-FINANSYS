// presentation/providers/presupuesto_provider.dart
// SOLID-SRP: gestiona únicamente el estado de presupuestos.

import 'package:flutter/foundation.dart';
import '../../domain/entities/presupuesto_entity.dart';
import '../../container.dart';
import '../errors/error_translator.dart';

class PresupuestoProvider extends ChangeNotifier {
  List<PresupuestoEntity> _presupuestos = [];
  bool _loading = false;
  String? _error;

  List<PresupuestoEntity> get presupuestos => _presupuestos;
  bool get loading => _loading;
  String? get error => _error;

  // Presupuestos del mes en curso, para el banner de alertas del dashboard.
  List<PresupuestoEntity> _mesActual = [];

  /// Presupuestos del mes actual que ya llegaron al 80 % o al 100 %,
  /// los más cargados primero.
  List<PresupuestoEntity> get alertas {
    final l = _mesActual.where((p) => p.nivel > 0).toList();
    l.sort((a, b) => b.ratio.compareTo(a.ratio));
    return l;
  }

  Future<void> loadAlertas() async {
    final hoy = DateTime.now();
    try {
      _mesActual =
          await Container.listBudgetsUseCase.execute(hoy.month, hoy.year);
    } catch (_) {
      // Las alertas son un extra: si fallan, no se muestra nada.
    }
    notifyListeners();
  }

  /// Foto del nivel de cada presupuesto (id -> nivel) antes de registrar un gasto.
  Future<Map<int, int>> instantanea(DateTime fecha) async {
    try {
      final l =
          await Container.listBudgetsUseCase.execute(fecha.month, fecha.year);
      return {for (final p in l) p.id: p.nivel};
    } catch (_) {
      return {};
    }
  }

  /// Presupuestos que subieron de nivel (cruzaron 80 % o 100 %) desde [antes].
  Future<List<PresupuestoEntity>> nuevasAlertas(
      Map<int, int> antes, DateTime fecha) async {
    try {
      final l =
          await Container.listBudgetsUseCase.execute(fecha.month, fecha.year);
      final hoy = DateTime.now();
      if (fecha.month == hoy.month && fecha.year == hoy.year) {
        _mesActual = l;
        notifyListeners();
      }
      return l.where((p) => p.nivel > (antes[p.id] ?? 0)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> loadBudgets(int mes, int anio) async {
    _loading = true;
    notifyListeners();
    try {
      _presupuestos = await Container.listBudgetsUseCase.execute(mes, anio);
      _error = null;
    } catch (e) {
      _error = ErrorTranslator.message(e);
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
      await loadAlertas();
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return false;
    }
  }
}
