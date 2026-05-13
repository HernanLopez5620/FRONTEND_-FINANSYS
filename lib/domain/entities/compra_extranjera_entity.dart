// domain/entities/compra_extranjera_entity.dart
class CompraExtranjeraEntity {
  final int id;
  final String nombre;
  final double montoOrigen;
  final String monedaOrigen;
  final double montoCop;
  final double tasa;
  final DateTime createdAt;

  const CompraExtranjeraEntity({
    required this.id,
    required this.nombre,
    required this.montoOrigen,
    required this.monedaOrigen,
    required this.montoCop,
    required this.tasa,
    required this.createdAt,
  });

  factory CompraExtranjeraEntity.fromJson(Map<String, dynamic> json) {
    return CompraExtranjeraEntity(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      montoOrigen:
          double.tryParse(json['monto_origen']?.toString() ?? '0') ?? 0,
      monedaOrigen: json['moneda_origen'] ?? '',
      montoCop: double.tryParse(json['monto_cop']?.toString() ?? '0') ?? 0,
      tasa: double.tryParse(json['tasa']?.toString() ?? '0') ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
