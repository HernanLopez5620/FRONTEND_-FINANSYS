// domain/ports/divisa_port.dart
// Contrato abstracto — correlacionado con exchange-rate.routes.js
// GET /api/v1/divisas/usd-cop
// GET /api/v1/divisas/convertir?monto=&de=&a=

import '../entities/tasa_cambio_entity.dart';

abstract class DivisaPort {
  // Obtener tasa de cambio USD → COP actual
  Future<TasaCambioEntity> getExchangeRate();

  // Convertir un monto entre dos monedas
  Future<ConversionEntity> convertCurrency({
    required double monto,
    required String de,
    required String a,
  });
}
