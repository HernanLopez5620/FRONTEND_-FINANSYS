// presentation/providers/divisa_provider.dart
// SOLID-SRP: gestiona únicamente el estado de divisas y conversión.

import 'package:flutter/foundation.dart';
import '../../domain/entities/tasa_cambio_entity.dart';
import '../../container.dart';

class DivisaProvider extends ChangeNotifier {
  TasaCambioEntity? _tasa;
  ConversionEntity? _conversion;
  bool _loading = false;
  String? _error;

  TasaCambioEntity? get tasa => _tasa;
  ConversionEntity? get conversion => _conversion;
  bool get loading => _loading;
  String? get error => _error;

  // Carga la tasa de cambio actual
  Future<void> loadExchangeRate() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _tasa = await Container.getExchangeRateUseCase.execute();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Convierte un monto entre monedas
  Future<void> convert({
    required double monto,
    required String de,
    required String a,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _conversion = await Container.convertCurrencyUseCase.execute(
        monto: monto,
        de: de,
        a: a,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clearConversion() {
    _conversion = null;
    notifyListeners();
  }
}
