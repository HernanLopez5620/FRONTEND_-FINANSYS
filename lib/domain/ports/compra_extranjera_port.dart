// domain/ports/compra_extranjera_port.dart
import '../entities/compra_extranjera_entity.dart';

abstract class CompraExtranjeraPort {
  Future<List<CompraExtranjeraEntity>> getAll();
  Future<CompraExtranjeraEntity> save({
    required String nombre,
    required double montoOrigen,
    required String monedaOrigen,
    required double montoCop,
    required double tasa,
  });
  Future<void> delete(int id);
}
