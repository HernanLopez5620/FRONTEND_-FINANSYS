// presentation/providers/compra_extranjera_provider.dart
import 'package:flutter/foundation.dart';
import '../../domain/entities/compra_extranjera_entity.dart';
import '../../container.dart';

class CompraExtranjeraProvider extends ChangeNotifier {
  List<CompraExtranjeraEntity> _compras = [];
  bool _loading = false;
  String? _error;

  List<CompraExtranjeraEntity> get compras => _compras;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadAll() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _compras = await Container.listarComprasUseCase.execute();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> guardar({
    required String nombre,
    required double montoOrigen,
    required String monedaOrigen,
    required double montoCop,
    required double tasa,
  }) async {
    try {
      final nueva = await Container.guardarCompraUseCase.execute(
        nombre: nombre,
        montoOrigen: montoOrigen,
        monedaOrigen: monedaOrigen,
        montoCop: montoCop,
        tasa: tasa,
      );
      _compras.insert(0, nueva);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> eliminar(int id) async {
    try {
      await Container.eliminarCompraUseCase.execute(id);
      _compras.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
