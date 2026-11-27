// domain/entities/meta_ahorro_entity.dart
// Meta de ahorro con su avance.
// Backend: { id, nombre, icono, monto_objetivo, ahorrado, restante, porcentaje, completada,
//            vencida, fecha_limite ('YYYY-MM-DD' o null), sugerido_mensual (o null) }

double _num(dynamic v) => double.tryParse(v?.toString() ?? '0') ?? 0;
DateTime? _fecha(dynamic v) =>
    v == null ? null : DateTime.tryParse(v.toString());

class MetaAhorroEntity {
  final int id;
  final String nombre;
  final String icono;
  final double montoObjetivo;
  final double ahorrado;
  final double restante;
  final int porcentaje; // 0-100
  final bool completada;
  final bool vencida;
  final DateTime? fechaLimite;
  final double? sugeridoMensual;

  const MetaAhorroEntity({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.montoObjetivo,
    required this.ahorrado,
    required this.restante,
    required this.porcentaje,
    required this.completada,
    required this.vencida,
    required this.fechaLimite,
    required this.sugeridoMensual,
  });

  factory MetaAhorroEntity.fromJson(Map<String, dynamic> json) {
    return MetaAhorroEntity(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      icono: json['icono'] ?? '🎯',
      montoObjetivo: _num(json['monto_objetivo']),
      ahorrado: _num(json['ahorrado']),
      restante: _num(json['restante']),
      porcentaje: (json['porcentaje'] as num?)?.toInt() ?? 0,
      completada: json['completada'] ?? false,
      vencida: json['vencida'] ?? false,
      fechaLimite: _fecha(json['fecha_limite']),
      sugeridoMensual: json['sugerido_mensual'] == null
          ? null
          : _num(json['sugerido_mensual']),
    );
  }
}

/// Un movimiento de la meta: monto positivo = aporte, negativo = retiro.
class AporteMetaEntity {
  final int id;
  final double monto;
  final String nota;
  final DateTime fecha;

  const AporteMetaEntity({
    required this.id,
    required this.monto,
    required this.nota,
    required this.fecha,
  });

  bool get esRetiro => monto < 0;

  factory AporteMetaEntity.fromJson(Map<String, dynamic> json) {
    return AporteMetaEntity(
      id: json['id'] ?? 0,
      monto: _num(json['monto']),
      nota: json['nota'] ?? '',
      fecha: _fecha(json['fecha']) ?? DateTime.now(),
    );
  }
}
