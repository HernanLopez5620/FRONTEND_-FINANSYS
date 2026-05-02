// domain/entities/tasa_cambio_entity.dart
// Entidad pura — correlacionada con exchange-rate.service.js del backend.
// Backend retorna: { base, cop, eur, gbp, ultima_actualizacion }

class TasaCambioEntity {
  final String base;
  final double cop;
  final double eur;
  final double gbp;
  final String ultimaActualizacion;

  const TasaCambioEntity({
    required this.base,
    required this.cop,
    required this.eur,
    required this.gbp,
    required this.ultimaActualizacion,
  });

  // GET /api/v1/divisas/usd-cop
  // Response: { ok: true, data: { base, cop, eur, gbp, ultima_actualizacion } }
  factory TasaCambioEntity.fromJson(Map<String, dynamic> json) {
    return TasaCambioEntity(
      base: json['base'] ?? 'USD',
      cop: double.tryParse(json['cop']?.toString() ?? '0') ?? 0,
      eur: double.tryParse(json['eur']?.toString() ?? '0') ?? 0,
      gbp: double.tryParse(json['gbp']?.toString() ?? '0') ?? 0,
      ultimaActualizacion: json['ultima_actualizacion'] ?? '',
    );
  }
}

// ── Resultado de conversión ──
// GET /api/v1/divisas/convertir?monto=&de=&a=
// Response: { monto_original, moneda_origen, moneda_destino, monto_convertido, tasa }
class ConversionEntity {
  final double montoOriginal;
  final String monedaOrigen;
  final String monedaDestino;
  final double montoConvertido;
  final double tasa;

  const ConversionEntity({
    required this.montoOriginal,
    required this.monedaOrigen,
    required this.monedaDestino,
    required this.montoConvertido,
    required this.tasa,
  });

  factory ConversionEntity.fromJson(Map<String, dynamic> json) {
    return ConversionEntity(
      montoOriginal:
          double.tryParse(json['monto_original']?.toString() ?? '0') ?? 0,
      monedaOrigen: json['moneda_origen'] ?? '',
      monedaDestino: json['moneda_destino'] ?? '',
      montoConvertido:
          double.tryParse(json['monto_convertido']?.toString() ?? '0') ?? 0,
      tasa: double.tryParse(json['tasa']?.toString() ?? '0') ?? 0,
    );
  }
}
