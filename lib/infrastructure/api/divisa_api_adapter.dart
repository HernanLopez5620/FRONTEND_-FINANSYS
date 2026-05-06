// infrastructure/api/divisa_api_adapter.dart
// Adaptador REAL — implementa DivisaPort conectando al backend.
// Correlacionado con exchange-rate.routes.js

import '../../domain/entities/tasa_cambio_entity.dart';
import '../../domain/ports/divisa_port.dart';
import 'http_client.dart';

class DivisaApiAdapter implements DivisaPort {
  final HttpClient _http;

  DivisaApiAdapter(this._http);

  // GET /api/v1/divisas/usd-cop  (requiere JWT)
  // Response: { ok: true, data: { base, cop, eur, gbp, ultima_actualizacion } }
  @override
  Future<TasaCambioEntity> getExchangeRate() async {
    final res = await _http.get('/divisas/usd-cop');
    return TasaCambioEntity.fromJson(res['data'] ?? {});
  }

  // GET /api/v1/divisas/convertir?monto=&de=&a=  (requiere JWT)
  // Response: { ok: true, data: { monto_convertido, tasa, ... } }
  @override
  Future<ConversionEntity> convertCurrency({
    required double monto,
    required String de,
    required String a,
  }) async {
    final res = await _http.get('/divisas/convertir?monto=$monto&de=$de&a=$a');
    return ConversionEntity.fromJson(res['data'] ?? {});
  }
}
