// domain/ports/meta_ahorro_port.dart
import '../entities/meta_ahorro_entity.dart';

abstract class MetaAhorroPort {
  Future<List<MetaAhorroEntity>> getAll();

  Future<MetaAhorroEntity> create({
    required String nombre,
    required String icono,
    required double montoObjetivo,
    String? fechaLimite,
  });

  /// `campos` usa los nombres del backend (nombre, icono, monto_objetivo, fecha_limite).
  /// Para quitar la fecha límite se envía `fecha_limite: null`.
  Future<MetaAhorroEntity> update(int id, Map<String, dynamic> campos);

  Future<void> delete(int id);

  /// [tipo]: 'aporte' o 'retiro'. El monto va siempre positivo.
  /// Devuelve la meta con su avance actualizado.
  Future<MetaAhorroEntity> registrarAporte(
    int metaId, {
    required double monto,
    required String tipo,
    String nota = '',
  });

  Future<List<AporteMetaEntity>> getAportes(int metaId);

  Future<MetaAhorroEntity> deleteAporte(int metaId, int aporteId);
}
