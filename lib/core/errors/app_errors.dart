// core/errors/app_errors.dart
// SOLID-SRP: cada clase representa un solo tipo de error.
// Nombres en inglés, claros y descriptivos.

class AppError implements Exception {
  /// Texto de respaldo (español del backend). La UI traduce con ErrorTranslator.
  final String message;
  final int statusCode;

  /// Código estable del backend (ej. 'AUTH_WRONG_PASSWORD') y sus parámetros.
  final String? code;
  final Map<String, dynamic> params;

  const AppError(this.message,
      {this.statusCode = 500, this.code, this.params = const {}});

  @override
  String toString() => message;
}

class UnauthorizedError extends AppError {
  const UnauthorizedError(
      [String msg = 'Correo o contraseña incorrectos',
      String? code,
      Map<String, dynamic> params = const {}])
      : super(msg, statusCode: 401, code: code, params: params);
}

/// El servidor indicó que esta sesión ya no es la activa
/// (code: 'SESION_REEMPLAZADA' o 'SESION_CERRADA').
class SessionReplacedError extends AppError {
  const SessionReplacedError(String msg, String code)
      : super(msg, statusCode: 401, code: code);
}

class ForbiddenError extends AppError {
  const ForbiddenError(
      [String msg = 'No tienes permiso para esta acción',
      String? code,
      Map<String, dynamic> params = const {}])
      : super(msg, statusCode: 403, code: code, params: params);
}

class NotFoundError extends AppError {
  const NotFoundError(
      [String msg = 'No encontrado',
      String? code,
      Map<String, dynamic> params = const {}])
      : super(msg, statusCode: 404, code: code, params: params);
}

class ValidationError extends AppError {
  const ValidationError(
      [String msg = 'Datos inválidos',
      String? code,
      Map<String, dynamic> params = const {}])
      : super(msg, statusCode: 400, code: code, params: params);
}

class NetworkError extends AppError {
  const NetworkError(
      [String msg = 'Sin conexión. Verifica que el servidor esté corriendo.'])
      : super(msg, statusCode: 0, code: 'NETWORK_ERROR');
}

class ConflictError extends AppError {
  const ConflictError(
      [String msg = 'El recurso ya existe',
      String? code,
      Map<String, dynamic> params = const {}])
      : super(msg, statusCode: 409, code: code, params: params);
}

class ServerError extends AppError {
  const ServerError(
      [String msg = 'Error interno del servidor',
      String? code,
      Map<String, dynamic> params = const {}])
      : super(msg, statusCode: 500, code: code, params: params);
}
