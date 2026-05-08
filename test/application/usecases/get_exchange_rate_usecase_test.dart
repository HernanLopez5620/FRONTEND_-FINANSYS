// Prueba unitaria de GetExchangeRateUseCase
// Se verifica que retorna la tasa de cambio correctamente
// desde la API externa de divisas

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/application/usecases/get_exchange_rate_usecase.dart';
import 'package:finansys/domain/entities/tasa_cambio_entity.dart';
import 'package:finansys/domain/ports/divisa_port.dart';

class MockDivisaPort implements DivisaPort {
  @override
  Future<TasaCambioEntity> getExchangeRate() async {
    return const TasaCambioEntity(
      base:                'USD',
      cop:                 4150.5,
      eur:                 0.92,
      gbp:                 0.79,
      ultimaActualizacion: 'Thu, 01 May 2026 00:00:01 +0000',
    );
  }

  @override
  Future<ConversionEntity> convertCurrency({
    required double monto,
    required String de,
    required String a,
  }) async => throw UnimplementedError();
}

void main() {
  group('GetExchangeRateUseCase', () {
    late GetExchangeRateUseCase useCase;

    setUp(() {
      useCase = GetExchangeRateUseCase(MockDivisaPort());
    });

    test('execute() retorna la tasa de cambio USD/COP', () async {
      final result = await useCase.execute();

      expect(result.base, equals('USD'));
      expect(result.cop,  equals(4150.5));
    });

    test('execute() retorna tasas EUR y GBP', () async {
      final result = await useCase.execute();

      expect(result.eur, equals(0.92));
      expect(result.gbp, equals(0.79));
    });

    test('execute() retorna fecha de actualización', () async {
      final result = await useCase.execute();

      expect(result.ultimaActualizacion, isNotEmpty);
    });
  });
}