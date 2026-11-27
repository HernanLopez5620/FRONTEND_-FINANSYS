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

  /// Proporción real gastado/límite (puede pasar de 1.0).
  double get ratio => montoLimite > 0 ? gastado / montoLimite : 0;

  /// Porcentaje usado, redondeado hacia abajo (ej. 84.9 % -> 84).
  int get porcentajeEntero => (ratio * 100).floor();

  /// 0 = normal, 1 = aviso (desde 80 %), 2 = superado (desde 100 %).
  int get nivel => ratio >= 1 ? 2 : (ratio >= 0.8 ? 1 : 0);

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
