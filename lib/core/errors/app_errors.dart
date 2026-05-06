// core/errors/app_errors.dart
// SOLID-SRP: cada clase representa un solo tipo de error.
// Nombres en inglés, claros y descriptivos.

class AppError implements Exception {
  final String message;
  final int statusCode;

  const AppError(this.message, {this.statusCode = 500});

  @override
  String toString() => message;
}

class UnauthorizedError extends AppError {
  const UnauthorizedError([String msg = 'Correo o contraseña incorrectos'])
      : super(msg, statusCode: 401);
}

class NotFoundError extends AppError {
  const NotFoundError([String msg = 'No encontrado'])
      : super(msg, statusCode: 404);
}

class ValidationError extends AppError {
  const ValidationError([String msg = 'Datos inválidos'])
      : super(msg, statusCode: 400);
}

class NetworkError extends AppError {
  const NetworkError(
      [String msg = 'Sin conexión. Verifica que el servidor esté corriendo.'])
      : super(msg, statusCode: 0);
}

class ConflictError extends AppError {
  const ConflictError([String msg = 'El recurso ya existe'])
      : super(msg, statusCode: 409);
}

class ServerError extends AppError {
  const ServerError([String msg = 'Error interno del servidor'])
      : super(msg, statusCode: 500);
}
