// domain/entities/presupuesto_entity.dart
// Query retorna: { id, nombre, icono, color, monto_limite, gastado }

class PresupuestoEntity {
  final int id;
  final String nombre;
  final String icono;
  final String color;
  final double montoLimite;
  final double gastado;

  const PresupuestoEntity({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.color,
    required this.montoLimite,
    required this.gastado,
  });

  double get porcentaje =>
      montoLimite > 0 ? (gastado / montoLimite).clamp(0.0, 1.0) : 0;

  bool get overBudget => gastado > montoLimite;

  factory PresupuestoEntity.fromJson(Map<String, dynamic> json) {
    return PresupuestoEntity(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      icono: json['icono'] ?? '📦',
      color: json['color'] ?? '#1A7A3C',
      montoLimite:
          double.tryParse(json['monto_limite']?.toString() ?? '0') ?? 0,
      gastado: double.tryParse(json['gastado']?.toString() ?? '0') ?? 0,
    );
  }
}
