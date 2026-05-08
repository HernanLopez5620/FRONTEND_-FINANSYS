// Prueba unitaria de MockDivisaAdapter
// Se verifica que el adaptador mock retorna tasas
// de cambio y conversiones correctas

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/infrastructure/api/mock_divisa_adapter.dart';

void main() {
  group('MockDivisaAdapter', () {
    late MockDivisaAdapter adapter;

    setUp(() {
      adapter = MockDivisaAdapter();
    });

    test('getExchangeRate() retorna tasa USD base', () async {
      final result = await adapter.getExchangeRate();

      expect(result.base, equals('USD'));
    });

    test('getExchangeRate() retorna cop mayor a 0', () async {
      final result = await adapter.getExchangeRate();

      expect(result.cop, greaterThan(0));
    });

    test('convertCurrency() USD a COP multiplica por la tasa', () async {
      final result = await adapter.convertCurrency(
        monto: 100,
        de:    'USD',
        a:     'COP',
      );

      expect(result.montoConvertido, equals(415050.0));
      expect(result.monedaOrigen,    equals('USD'));
      expect(result.monedaDestino,   equals('COP'));
    });

    test('convertCurrency() COP a USD divide por la tasa', () async {
      final result = await adapter.convertCurrency(
        monto: 4150.5,
        de:    'COP',
        a:     'USD',
      );

      expect(result.montoConvertido, closeTo(1.0, 0.001));
    });

    test('convertCurrency() retorna monto original correcto', () async {
      final result = await adapter.convertCurrency(
        monto: 500,
        de:    'USD',
        a:     'COP',
      );

      expect(result.montoOriginal, equals(500.0));
    });
  });
}