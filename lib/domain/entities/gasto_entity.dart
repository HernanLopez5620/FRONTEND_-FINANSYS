// domain/entities/gasto_entity.dart
// Correlacionada con gasto.entity.js del backend.
// Backend retorna en listar:
// { id, monto, descripcion, fecha, tipo, categoria, icono, color }
// Backend recibe en crear:
// { categoria_id, monto, descripcion, fecha, tipo }

class GastoEntity {
  final int id;
  final int? userId;
  final int? categoriaId;
  final double monto;
  final String descripcion;
  final DateTime fecha;
  final String tipo; // 'gasto' | 'ingreso'
  final String? categoria;
  final String? icono;
  final String? color;

  const GastoEntity({
    required this.id,
    required this.monto,
    required this.descripcion,
    required this.fecha,
    required this.tipo,
    this.userId,
    this.categoriaId,
    this.categoria,
    this.icono,
    this.color,
  });

  bool get esGasto => tipo == 'gasto';
  bool get esIngreso => tipo == 'ingreso';

  factory GastoEntity.fromJson(Map<String, dynamic> json) {
    return GastoEntity(
      id: json['id'] ?? 0,
      userId: json['user_id'],
      categoriaId: json['categoria_id'],
      monto: double.tryParse(json['monto'].toString()) ?? 0,
      descripcion: json['descripcion'] ?? '',
      fecha: DateTime.tryParse(json['fecha'].toString()) ?? DateTime.now(),
      tipo: json['tipo'] ?? 'gasto',
      categoria: json['categoria'] ?? '',
      icono: json['icono'] ?? '📦',
      color: json['color'] ?? '#1A7A3C',
    );
  }

  // Body para POST /api/v1/gastos
  Map<String, dynamic> toCreateJson() => {
        'categoria_id': categoriaId,
        'monto': monto,
        'descripcion': descripcion,
        'fecha': fecha.toIso8601String().split('T')[0],
        'tipo': tipo,
      };

  // Body para PUT /api/v1/gastos/:id
  Map<String, dynamic> toUpdateJson() => {
        if (categoriaId != null) 'categoria_id': categoriaId,
        'monto': monto,
        'descripcion': descripcion,
        'fecha': fecha.toIso8601String().split('T')[0],
        'tipo': tipo,
      };
}
