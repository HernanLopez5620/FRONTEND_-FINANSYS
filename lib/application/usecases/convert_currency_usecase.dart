// application/usecases/convert_currency_usecase.dart
// SOLID-SRP: única responsabilidad — convertir un monto entre monedas.
// Correlacionado con GET /api/v1/divisas/convertir?monto=&de=&a=

import '../../domain/entities/tasa_cambio_entity.dart';
import '../../domain/ports/divisa_port.dart';

class ConvertCurrencyUseCase {
  final DivisaPort _divisaPort;

  ConvertCurrencyUseCase(this._divisaPort);

  Future<ConversionEntity> execute({
    required double monto,
    required String de,
    required String a,
  }) {
    return _divisaPort.convertCurrency(
      monto: monto,
      de: de,
      a: a,
    );
  }
}
