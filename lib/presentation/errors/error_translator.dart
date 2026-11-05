// presentation/errors/error_translator.dart
// Traduce los errores de la API (código estable + parámetros) al idioma activo.
// Los providers guardan un String ya traducido: el idioma actual lo da Formatters.idioma.
// Código desconocido → se muestra el `msg` que envió el backend (o un texto genérico).

import 'package:flutter/widgets.dart';

import '../../core/errors/app_errors.dart';
import '../../core/utils/formatters.dart';
import '../../l10n/l10n.dart';

class ErrorTranslator {
  ErrorTranslator._();

  /// Códigos que sabe traducir (debe coincidir con el catálogo del backend:
  /// lo comprueba test/error_codes_test.dart).
  static const supportedCodes = <String>{
    'VALIDATION_MISSING_FIELDS',
    'VALIDATION_USERNAME_FORMAT',
    'VALIDATION_PASSWORD_MIN',
    'VALIDATION_NOTHING_TO_UPDATE',
    'VALIDATION_INVALID_THEME',
    'VALIDATION_INVALID_FORMAT',
    'VALIDATION_INVALID_MONTH',
    'VALIDATION_INVALID_YEAR',
    'VALIDATION_INVALID_UID',
    'AUTH_USER_NOT_FOUND',
    'AUTH_WRONG_PASSWORD',
    'AUTH_TOKEN_MISSING',
    'AUTH_TOKEN_INVALID',
    'SESION_CERRADA',
    'SESION_REEMPLAZADA',
    'AUTH_SESSION_CHECK_FAILED',
    'AUTH_FORBIDDEN_ADMIN_ONLY',
    'AUTH_ACCOUNT_DISABLED',
    'AUTH_RESET_LINK_INVALID',
    'AUTH_GOOGLE_TOKEN_MISSING',
    'AUTH_GOOGLE_TOKEN_INVALID',
    'AUTH_GOOGLE_EMAIL_UNVERIFIED',
    'AUTH_GOOGLE_NOT_CONFIGURED',
    'CONFLICT_EMAIL_TAKEN',
    'CONFLICT_USERNAME_TAKEN',
    'NOT_FOUND_EXPENSE',
    'NOT_FOUND_ROUTE',
    'RATE_LIMIT_DAILY',
    'EXTERNAL_RATE_FETCH_FAILED',
    'EXTERNAL_CONVERT_FAILED',
    'INTERNAL_ERROR',
    'NETWORK_ERROR',
  };

  static String _s(Object? v) => v?.toString() ?? '';
  static int _i(Object? v) => v is num ? v.toInt() : int.tryParse(_s(v)) ?? 0;

  /// Texto traducido para mostrar al usuario. [l] solo se pasa en tests.
  static String message(Object error, [AppLocalizations? l]) {
    l ??= lookupAppLocalizations(Locale(Formatters.idioma));
    if (error is AppError) {
      final traducido = _porCodigo(l, error.code, error.params);
      if (traducido != null) return traducido;
      if (error.message.isNotEmpty) return error.message;
    }
    return l.errUnknown;
  }

  static String? _porCodigo(
      AppLocalizations l, String? code, Map<String, dynamic> params) {
    switch (code) {
      case 'VALIDATION_MISSING_FIELDS':
        return l.errValidationMissingFields(_s(params['fields']));
      case 'VALIDATION_USERNAME_FORMAT':
        return l.errValidationUsernameFormat;
      case 'VALIDATION_PASSWORD_MIN':
        return l.errValidationPasswordMin(_i(params['min']));
      case 'VALIDATION_NOTHING_TO_UPDATE':
        return l.errValidationNothingToUpdate;
      case 'VALIDATION_INVALID_THEME':
        return l.errValidationInvalidTheme;
      case 'VALIDATION_INVALID_FORMAT':
        return l.errValidationInvalidFormat;
      case 'VALIDATION_INVALID_MONTH':
        return l.errValidationInvalidMonth;
      case 'VALIDATION_INVALID_YEAR':
        return l.errValidationInvalidYear;
      case 'VALIDATION_INVALID_UID':
        return l.errValidationInvalidUid;
      case 'AUTH_USER_NOT_FOUND':
        return l.errAuthUserNotFound;
      case 'AUTH_WRONG_PASSWORD':
        return l.errAuthWrongPassword;
      case 'AUTH_TOKEN_MISSING':
        return l.errAuthTokenMissing;
      case 'AUTH_TOKEN_INVALID':
        return l.errAuthTokenInvalid;
      case 'SESION_CERRADA':
        return l.errSesionCerrada;
      case 'SESION_REEMPLAZADA':
        return l.errSesionReemplazada;
      case 'AUTH_SESSION_CHECK_FAILED':
        return l.errAuthSessionCheckFailed;
      case 'AUTH_FORBIDDEN_ADMIN_ONLY':
        return l.errAuthForbiddenAdminOnly;
      case 'AUTH_ACCOUNT_DISABLED':
        return l.errAuthAccountDisabled;
      case 'AUTH_RESET_LINK_INVALID':
        return l.errAuthResetLinkInvalid;
      case 'AUTH_GOOGLE_TOKEN_MISSING':
        return l.errAuthGoogleTokenMissing;
      case 'AUTH_GOOGLE_TOKEN_INVALID':
        return l.errAuthGoogleTokenInvalid;
      case 'AUTH_GOOGLE_EMAIL_UNVERIFIED':
        return l.errAuthGoogleEmailUnverified;
      case 'AUTH_GOOGLE_NOT_CONFIGURED':
        return l.errAuthGoogleNotConfigured;
      case 'CONFLICT_EMAIL_TAKEN':
        return l.errConflictEmailTaken;
      case 'CONFLICT_USERNAME_TAKEN':
        return l.errConflictUsernameTaken;
      case 'NOT_FOUND_EXPENSE':
        return l.errNotFoundExpense;
      case 'NOT_FOUND_ROUTE':
        return l.errNotFoundRoute;
      case 'RATE_LIMIT_DAILY':
        return l.errRateLimitDaily(_i(params['limit']));
      case 'EXTERNAL_RATE_FETCH_FAILED':
        return l.errExternalRateFetchFailed;
      case 'EXTERNAL_CONVERT_FAILED':
        return l.errExternalConvertFailed;
      case 'INTERNAL_ERROR':
        return l.errInternalError;
      case 'NETWORK_ERROR':
        return l.errNetwork;
    }
    return null;
  }
}
