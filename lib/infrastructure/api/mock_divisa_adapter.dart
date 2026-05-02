// infrastructure/api/mock_divisa_adapter.dart
// Adaptador MOCK — para desarrollo sin backend activo.
// SOLID-LSP: reemplaza a DivisaApiAdapter sin romper nada.

import '../../domain/entities/tasa_cambio_entity.dart';
import '../../domain/ports/divisa_port.dart';

class MockDivisaAdapter implements DivisaPort {
  @override
  Future<TasaCambioEntity> getExchangeRate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const TasaCambioEntity(
      base: 'USD',
      cop: 4150.5,
      eur: 0.92,
      gbp: 0.79,
      ultimaActualizacion: 'Thu, 01 May 2026 00:00:01 +0000',
    );
  }

  @override
  Future<ConversionEntity> convertCurrency({
    required double monto,
    required String de,
    required String a,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulación simple de conversión
    double resultado = monto;
    double tasa = 1.0;

    if (de == 'USD' && a == 'COP') {
      tasa = 4150.5;
      resultado = monto * tasa;
    } else if (de == 'COP' && a == 'USD') {
      tasa = 1 / 4150.5;
      resultado = monto * tasa;
    } else if (de == 'USD' && a == 'EUR') {
      tasa = 0.92;
      resultado = monto * tasa;
    }

    return ConversionEntity(
      montoOriginal: monto,
      monedaOrigen: de,
      monedaDestino: a,
      montoConvertido: resultado,
      tasa: tasa,
    );
  }
}
