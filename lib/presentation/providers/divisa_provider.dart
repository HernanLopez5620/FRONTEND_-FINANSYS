// presentation/providers/divisa_provider.dart
// SOLID-SRP: gestiona únicamente el estado de divisas y conversión.

import 'package:flutter/foundation.dart';
import 'dart:async';
import '../../domain/entities/tasa_cambio_entity.dart';
import '../../container.dart';

class DivisaProvider extends ChangeNotifier {
  TasaCambioEntity? _tasa;
  ConversionEntity? _conversion;
  bool _loading = false;
  String? _error;
  Timer? _debounce;

  TasaCambioEntity? get tasa => _tasa;
  ConversionEntity? get conversion => _conversion;
  bool get loading => _loading;
  String? get error => _error;

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

  // Conversión con debounce — espera 500ms después de que el usuario deje de escribir
  void convertDebounced({
    required double monto,
    required String de,
    required String a,
  }) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      convert(monto: monto, de: de, a: a);
    });
  }

  Future<void> convert({
    required double monto,
    required String de,
    required String a,
  }) async {
    if (monto <= 0) {
      _conversion = null;
      notifyListeners();
      return;
    }
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
    _debounce?.cancel();
    _conversion = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
