// presentation/providers/meta_ahorro_provider.dart
// SOLID-SRP: estado de las metas de ahorro.

import 'package:flutter/foundation.dart';
import '../../domain/entities/meta_ahorro_entity.dart';
import '../../container.dart';
import '../errors/error_translator.dart';

class MetaAhorroProvider extends ChangeNotifier {
  List<MetaAhorroEntity> _metas = [];
  bool _loading = false;
  String? _error;

  List<MetaAhorroEntity> get metas => _metas;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadAll() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _metas = await Container.listarMetasUseCase.execute();
    } catch (e) {
      _error = ErrorTranslator.message(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> crear({
    required String nombre,
    required String icono,
    required double montoObjetivo,
    String? fechaLimite,
  }) async {
    _error = null;
    try {
      await Container.crearMetaUseCase.execute(
        nombre: nombre,
        icono: icono,
        montoObjetivo: montoObjetivo,
        fechaLimite: fechaLimite,
      );
      await loadAll();
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> actualizar(int id, Map<String, dynamic> campos) async {
    _error = null;
    try {
      _reemplazar(await Container.actualizarMetaUseCase.execute(id, campos));
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await Container.eliminarMetaUseCase.execute(id);
      _metas.removeWhere((m) => m.id == id);
      notifyListeners();
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
    }
  }

  /// [tipo]: 'aporte' o 'retiro'. Devuelve true si se registró.
  Future<bool> registrarAporte(
    MetaAhorroEntity meta, {
    required double monto,
    required String tipo,
    String nota = '',
  }) async {
    _error = null;
    try {
      _reemplazar(await Container.registrarAporteMetaUseCase
          .execute(meta.id, monto: monto, tipo: tipo, nota: nota));
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return false;
    }
  }

  Future<List<AporteMetaEntity>> cargarAportes(int metaId) async {
    _error = null;
    try {
      return await Container.listarAportesMetaUseCase.execute(metaId);
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return [];
    }
  }

  Future<bool> eliminarAporte(int metaId, int aporteId) async {
    _error = null;
    try {
      _reemplazar(
          await Container.eliminarAporteMetaUseCase.execute(metaId, aporteId));
      return true;
    } catch (e) {
      _error = ErrorTranslator.message(e);
      notifyListeners();
      return false;
    }
  }

  MetaAhorroEntity? porId(int id) {
    for (final m in _metas) {
      if (m.id == id) return m;
    }
    return null;
  }

  void _reemplazar(MetaAhorroEntity nueva) {
    final i = _metas.indexWhere((m) => m.id == nueva.id);
    if (i >= 0) _metas[i] = nueva;
    notifyListeners();
  }
}
