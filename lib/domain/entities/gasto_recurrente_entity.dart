// domain/entities/gasto_recurrente_entity.dart
// Regla que genera movimientos cada semana / mes / año.
// Backend: { id, categoria_id, categoria, icono, color, monto, descripcion, tipo,
//            frecuencia, fecha_inicio, proxima_fecha, fecha_fin, activo }  (fechas 'YYYY-MM-DD')

class GastoRecurrenteEntity {
  final int id;
  final int categoriaId;
  final String categoria;
  final String icono;
  final String color;
  final double monto;
  final String descripcion;
  final String tipo; // 'gasto' | 'ingreso'
  final String frecuencia; // 'semanal' | 'mensual' | 'anual'
  final DateTime fechaInicio;
  final DateTime proximaFecha;
  final DateTime? fechaFin;
  final bool activo;

  const GastoRecurrenteEntity({
    required this.id,
    required this.categoriaId,
    required this.categoria,
    required this.icono,
    required this.color,
    required this.monto,
    required this.descripcion,
    required this.tipo,
    required this.frecuencia,
    required this.fechaInicio,
    required this.proximaFecha,
    required this.fechaFin,
    required this.activo,
  });

  bool get esGasto => tipo == 'gasto';

  static DateTime? _fecha(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());

  factory GastoRecurrenteEntity.fromJson(Map<String, dynamic> json) {
    return GastoRecurrenteEntity(
      id: json['id'] ?? 0,
      categoriaId: json['categoria_id'] ?? 0,
      categoria: json['categoria'] ?? '',
      icono: json['icono'] ?? '📦',
      color: json['color'] ?? '#1A7A3C',
      monto: double.tryParse(json['monto']?.toString() ?? '0') ?? 0,
      descripcion: json['descripcion'] ?? '',
      tipo: json['tipo'] ?? 'gasto',
      frecuencia: json['frecuencia'] ?? 'mensual',
      fechaInicio: _fecha(json['fecha_inicio']) ?? DateTime.now(),
      proximaFecha: _fecha(json['proxima_fecha']) ?? DateTime.now(),
      fechaFin: _fecha(json['fecha_fin']),
      activo: json['activo'] ?? true,
    );
  }
}
