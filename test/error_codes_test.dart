// test/error_codes_test.dart
// Mantiene sincronizados el catálogo de errores del backend (copia en
// test/fixtures/error-codes.json) y las traducciones de Flutter.
// Si el backend agrega un código: copia el JSON actualizado, agrega la clave
// errXxxYyy en app_es.arb y app_en.arb, y el caso en ErrorTranslator.

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:finansys/core/errors/app_errors.dart';
import 'package:finansys/l10n/l10n.dart';
import 'package:finansys/presentation/errors/error_translator.dart';

String _key(String code) =>
    'err${code.split('_').map((p) => p[0] + p.substring(1).toLowerCase()).join()}';

Map<String, dynamic> _json(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  final catalog = _json('test/fixtures/error-codes.json');
  final es = _json('lib/l10n/app_es.arb');
  final en = _json('lib/l10n/app_en.arb');

  test('ErrorTranslator soporta exactamente los códigos del catálogo', () {
    final soportados = ErrorTranslator.supportedCodes.toSet()
      ..remove('NETWORK_ERROR');
    expect(soportados, catalog.keys.toSet());
  });

  test('cada código tiene su clave en los ARB es y en', () {
    for (final code in catalog.keys) {
      expect(es.containsKey(_key(code)), isTrue,
          reason: 'app_es.arb: ${_key(code)}');
      expect(en.containsKey(_key(code)), isTrue,
          reason: 'app_en.arb: ${_key(code)}');
    }
  });

  for (final lang in ['es', 'en']) {
    test('todos los códigos se traducen en $lang', () {
      final l = lookupAppLocalizations(Locale(lang));
      for (final code in catalog.keys) {
        final err = AppError('texto-de-respaldo',
            code: code, params: {'fields': 'email', 'min': 6, 'limit': 100});
        final txt = ErrorTranslator.message(err, l);
        expect(txt, isNot('texto-de-respaldo'), reason: code);
        expect(txt.isNotEmpty, isTrue, reason: code);
      }
    });
  }

  test('parámetros se interpolan', () {
    final l = lookupAppLocalizations(const Locale('en'));
    final t = ErrorTranslator.message(
        const AppError('x',
            code: 'VALIDATION_PASSWORD_MIN', params: {'min': 6}),
        l);
    expect(t, contains('6'));
  });

  test('código desconocido usa el msg del backend; sin msg, texto genérico',
      () {
    final l = lookupAppLocalizations(const Locale('es'));
    expect(
        ErrorTranslator.message(
            const AppError('Mensaje del servidor', code: 'NUEVO'), l),
        'Mensaje del servidor');
    expect(ErrorTranslator.message(Exception('boom'), l), l.errUnknown);
  });
}
