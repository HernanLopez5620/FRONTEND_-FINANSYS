// presentation/providers/gasto_recurrente_provider.dart
// SOLID-SRP: estado de los gastos recurrentes.

import 'package:flutter/foundation.dart';
import '../../domain/entities/gasto_recurrente_entity.dart';
import '../../container.dart';
import '../errors/error_translator.dart';

class GastoRecurrenteProvider extends ChangeNotifier {
  List<GastoRecurrenteEntity> _reglas = [];
  bool _loading = false;
  String? _error;

  List<GastoRecurrenteEntity> get reglas => _reglas;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadAll() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _reglas = await Container.listarGastosRecurrentesUseCase.execute();
    } catch (e) {
      _error = ErrorTranslator.message(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Registra los movimientos vencidos. Nunca lanza: si falla, devuelve 0
  /// (no debe bloquear la carga del dashboard).
  Future<int> procesar() async {
    try {
      return await Container.procesarGastosRecurrentesUseCase.execute();
    } catch (_) {
      return 0;
    }
  }

  /// Devuelve cuántos movimientos se registraron al crear, o -1 si falló.
  Future<int> crear({
    required int categoriaId,
    required double monto,
    required String descripcion,
    required String tipo,
    required String frecuencia,
    required String fechaInicio,
    String? fechaFin,
  }) async {
    _error = null;
    try {
      final r = await Container.crearGastoRecurrenteUseCase.execute(
        categoriaId: categoriaId,
        monto: monto,
        descripcion: descripcion,
        tipo: tipo,
        frecuencia: frecuencia,
        fechaInicio: fechaInicio,
        fechaFin: fechaFin,
      );
      await loadAll();
      return r.generados;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return -1;
    }
  }

  Future<bool> cambiarActivo(GastoRecurrenteEntity regla, bool activo) async {
    return _actualizar(regla.id, {'activo': activo});
  }

  Future<bool> _actualizar(int id, Map<String, dynamic> campos) async {
    _error = null;
    try {
      final nueva =
          await Container.actualizarGastoRecurrenteUseCase.execute(id, campos);
      final i = _reglas.indexWhere((r) => r.id == id);
      if (i >= 0) _reglas[i] = nueva;
      notifyListeners();
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await Container.eliminarGastoRecurrenteUseCase.execute(id);
      _reglas.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
    }
  }
}
