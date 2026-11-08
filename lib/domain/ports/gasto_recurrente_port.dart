// domain/ports/gasto_recurrente_port.dart
import '../entities/gasto_recurrente_entity.dart';

abstract class GastoRecurrentePort {
  Future<List<GastoRecurrenteEntity>> getAll();

  /// Crea la regla. `generados` = movimientos que ya tocaban y se registraron al crearla.
  Future<({GastoRecurrenteEntity regla, int generados})> create({
    required int categoriaId,
    required double monto,
    required String descripcion,
    required String tipo,
    required String frecuencia,
    required String fechaInicio,
    String? fechaFin,
  });

  /// `campos` usa los nombres del backend (monto, frecuencia, activo, fecha_fin...).
  Future<GastoRecurrenteEntity> update(int id, Map<String, dynamic> campos);

  Future<void> delete(int id);

  /// Registra los movimientos vencidos. Devuelve cuántos creó.
  Future<int> procesar();
}
