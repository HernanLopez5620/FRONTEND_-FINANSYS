// presentation/providers/idioma_provider.dart
// SOLID-SRP: única responsabilidad — idioma activo de la app.
// Se guarda en el navegador (shared_preferences) para recordarlo la próxima vez.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/formatters.dart';

class IdiomaProvider extends ChangeNotifier {
  static const _clave = 'finansys_idioma';

  /// Idiomas disponibles (deben coincidir con los archivos app_XX.arb).
  static const soportados = <Locale>[Locale('es'), Locale('en')];

  /// Nombre de cada idioma en su propio idioma (no se traduce).
  static const nombres = <String, String>{
    'es': 'Español',
    'en': 'English',
  };

  Locale _locale = const Locale('es');
  Locale get locale => _locale;

  /// Lee el idioma guardado (si existe). Llamar antes de arrancar la app.
  Future<void> cargar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_clave);
      if (code != null && nombres.containsKey(code)) {
        _aplicar(Locale(code));
      }
    } catch (_) {
      // Sin almacenamiento disponible: se queda en español.
    }
  }

  Future<void> setLocale(Locale nuevo) async {
    if (!nombres.containsKey(nuevo.languageCode)) return;
    if (nuevo.languageCode == _locale.languageCode) return;
    _aplicar(nuevo);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_clave, nuevo.languageCode);
    } catch (_) {}
  }

  void _aplicar(Locale l) {
    _locale = Locale(l.languageCode);
    // Los formateadores (fechas, moneda) usan el mismo idioma.
    Formatters.idioma = l.languageCode;
  }
}
