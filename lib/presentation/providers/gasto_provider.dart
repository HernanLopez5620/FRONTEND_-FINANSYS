// presentation/providers/gasto_provider.dart
// SOLID-SRP: gestiona únicamente el estado de gastos e ingresos.

import 'package:flutter/foundation.dart';
import '../../domain/entities/gasto_entity.dart';
import '../../domain/entities/resumen_mes_entity.dart';
import '../../domain/entities/gasto_categoria_entity.dart';
import '../../domain/entities/comparacion_mensual_entity.dart';
import '../../container.dart';

class GastoProvider extends ChangeNotifier {
  List<GastoEntity> _gastos = [];
  ResumenMesEntity? _resumen;
  List<GastoCategoriaEntity> _porCategoria = [];
  List<ComparacionMensualEntity> _comparacion = [];
  bool _loading = false;
  String? _error;
  DateTime _selectedMonth = DateTime.now();

  List<GastoEntity> get gastos => _gastos;
  ResumenMesEntity? get resumen => _resumen;
  List<GastoCategoriaEntity> get porCategoria => _porCategoria;
  List<ComparacionMensualEntity> get comparacion => _comparacion;
  bool get loading => _loading;
  String? get error => _error;
  DateTime get selectedMonth => _selectedMonth;

  // Carga todo en paralelo para el mes seleccionado
  Future<void> loadAll() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final mes = _selectedMonth.month;
      final anio = _selectedMonth.year;
      final results = await Future.wait([
        Container.listExpensesUseCase.execute(mes: mes, anio: anio),
        Container.getMonthSummaryUseCase.execute(mes, anio),
        Container.getExpensesByCategoryUseCase.execute(mes, anio),
        Container.getMonthlyComparisonUseCase.execute(),
      ]);
      _gastos = results[0] as List<GastoEntity>;
      _resumen = results[1] as ResumenMesEntity;
      _porCategoria = results[2] as List<GastoCategoriaEntity>;
      _comparacion = results[3] as List<ComparacionMensualEntity>;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> createExpense(GastoEntity gasto) async {
    try {
      final nuevo = await Container.createExpenseUseCase.execute(gasto);
      _gastos.insert(0, nuevo);
      notifyListeners();
      await loadAll();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateExpense(int id, GastoEntity gasto) async {
    try {
      await Container.updateExpenseUseCase.execute(id, gasto);
      await loadAll();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteExpense(int id) async {
    try {
      await Container.deleteExpenseUseCase.execute(id);
      _gastos.removeWhere((g) => g.id == id);
      notifyListeners();
      await loadAll();
      return true;
    } catch (_) {
      return false;
    }
  }

  void setMonth(DateTime month) {
    _selectedMonth = month;
    loadAll();
  }
}
