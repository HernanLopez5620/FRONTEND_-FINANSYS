// domain/entities/resumen_mes_entity.dart
// El backend retorna: { ingresos, gastos, balance }

class ResumenMesEntity {
  final double ingresos;
  final double gastos;
  final double balance;

  const ResumenMesEntity({
    required this.ingresos,
    required this.gastos,
    required this.balance,
  });

  double get savingsPercent => ingresos > 0 ? (balance / ingresos) * 100 : 0;

  factory ResumenMesEntity.fromJson(Map<String, dynamic> json) {
    return ResumenMesEntity(
      ingresos: double.tryParse(json['ingresos']?.toString() ?? '0') ?? 0,
      gastos: double.tryParse(json['gastos']?.toString() ?? '0') ?? 0,
      balance: double.tryParse(json['balance']?.toString() ?? '0') ?? 0,
    );
  }
}
