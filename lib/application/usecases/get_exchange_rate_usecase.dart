// application/usecases/get_exchange_rate_usecase.dart
// SOLID-SRP: única responsabilidad — obtener tasa de cambio USD/COP.
// Correlacionado con GET /api/v1/divisas/usd-cop

import '../../domain/entities/tasa_cambio_entity.dart';
import '../../domain/ports/divisa_port.dart';

class GetExchangeRateUseCase {
  final DivisaPort _divisaPort;

  GetExchangeRateUseCase(this._divisaPort);

  Future<TasaCambioEntity> execute() {
    return _divisaPort.getExchangeRate();
  }
}
