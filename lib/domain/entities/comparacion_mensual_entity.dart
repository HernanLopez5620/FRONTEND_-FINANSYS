// domain/entities/comparacion_mensual_entity.dart
// Backend usa EXTRACT() → retorna como numeric, se parsea a int/double

class ComparacionMensualEntity {
  final int anio;
  final int mes;
  final double gastos;
  final double ingresos;

  const ComparacionMensualEntity({
    required this.anio,
    required this.mes,
    required this.gastos,
    required this.ingresos,
  });

  double get balance => ingresos - gastos;

  String get mesLabel {
    const meses = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return meses[(mes - 1).clamp(0, 11)];
  }

  factory ComparacionMensualEntity.fromJson(Map<String, dynamic> json) {
    return ComparacionMensualEntity(
      anio: (double.tryParse(json['anio']?.toString() ?? '0') ?? 0).toInt(),
      mes: (double.tryParse(json['mes']?.toString() ?? '0') ?? 0).toInt(),
      gastos: double.tryParse(json['gastos']?.toString() ?? '0') ?? 0,
      ingresos: double.tryParse(json['ingresos']?.toString() ?? '0') ?? 0,
    );
  }
}
