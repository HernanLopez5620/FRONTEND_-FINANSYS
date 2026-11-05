// l10n/l10n.dart
// Atajo para usar los textos traducidos:  context.l10n.miClave
// (AppLocalizations lo genera `flutter pub get` a partir de los archivos .arb)

import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

extension AppL10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
