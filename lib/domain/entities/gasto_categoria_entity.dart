// domain/entities/gasto_categoria_entity.dart
// Query retorna: { nombre, icono, color, total }

class GastoCategoriaEntity {
  final String nombre;
  final String icono;
  final String color;
  final double total;

  const GastoCategoriaEntity({
    required this.nombre,
    required this.icono,
    required this.color,
    required this.total,
  });

  factory GastoCategoriaEntity.fromJson(Map<String, dynamic> json) {
    return GastoCategoriaEntity(
      nombre: json['nombre'] ?? '',
      icono: json['icono'] ?? '📦',
      color: json['color'] ?? '#1A7A3C',
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0,
    );
  }
}
