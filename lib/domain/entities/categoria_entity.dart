// domain/entities/categoria_entity.dart
// Correlacionada con categoria.pg.repository.js del backend.
// Backend retorna: { id, nombre, icono, color, tipo }

class CategoriaEntity {
  final int id;
  final String nombre;
  final String icono;
  final String color;
  final String tipo; // 'gasto' | 'ingreso'

  const CategoriaEntity({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.color,
    required this.tipo,
  });

  factory CategoriaEntity.fromJson(Map<String, dynamic> json) {
    return CategoriaEntity(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      icono: json['icono'] ?? '📦',
      color: json['color'] ?? '#1A7A3C',
      tipo: json['tipo'] ?? 'gasto',
    );
  }

  // Body para POST /api/v1/categorias
  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'icono': icono,
        'color': color,
        'tipo': tipo,
      };
}
