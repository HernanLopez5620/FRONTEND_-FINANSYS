// application/usecases/recuperar_contrasena_usecases.dart
import '../../domain/ports/auth_port.dart';

/// Pide el correo con el enlace para restablecer la contraseña.
/// El backend responde igual exista o no el correo (no revela quién está registrado).
class SolicitarRecuperacionUseCase {
  final AuthPort _port;
  SolicitarRecuperacionUseCase(this._port);
  Future<void> execute(String email) => _port.forgotPassword(email: email);
}

class RestablecerContrasenaUseCase {
  final AuthPort _port;
  RestablecerContrasenaUseCase(this._port);
  Future<void> execute({required String token, required String password}) =>
      _port.resetPassword(token: token, password: password);
}
