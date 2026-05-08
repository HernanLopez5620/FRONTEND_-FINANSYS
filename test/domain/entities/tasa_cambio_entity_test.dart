// Prueba unitaria de TasaCambioEntity y ConversionEntity
// Se verifica que fromJson() parsea los datos de la API externa
// GET /api/v1/divisas/usd-cop y GET /api/v1/divisas/convertir

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/domain/entities/tasa_cambio_entity.dart';

void main() {
  group('TasaCambioEntity', () {

    test('fromJson() parsea correctamente la tasa de cambio', () {
      final json = {
        'base':                'USD',
        'cop':                 4150.5,
        'eur':                 0.92,
        'gbp':                 0.79,
        'ultima_actualizacion': 'Thu, 01 May 2026 00:00:01 +0000',
      };

      final tasa = TasaCambioEntity.fromJson(json);

      expect(tasa.base, equals('USD'));
      expect(tasa.cop,  equals(4150.5));
      expect(tasa.eur,  equals(0.92));
      expect(tasa.gbp,  equals(0.79));
    });

    test('fromJson() usa valores por defecto si faltan campos', () {
      final tasa = TasaCambioEntity.fromJson({});

      expect(tasa.base, equals('USD'));
      expect(tasa.cop,  equals(0.0));
    });
  });

  group('ConversionEntity', () {

    test('fromJson() parsea correctamente el resultado de conversión', () {
      final json = {
        'monto_original':   100.0,
        'moneda_origen':    'USD',
        'moneda_destino':   'COP',
        'monto_convertido': 415050.0,
        'tasa':             4150.5,
      };

      final conv = ConversionEntity.fromJson(json);

      expect(conv.montoOriginal,   equals(100.0));
      expect(conv.monedaOrigen,    equals('USD'));
      expect(conv.monedaDestino,   equals('COP'));
      expect(conv.montoConvertido, equals(415050.0));
      expect(conv.tasa,            equals(4150.5));
    });
  });
}