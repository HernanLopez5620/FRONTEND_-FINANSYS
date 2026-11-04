// application/usecases/login_google_usecase.dart
// SOLID-SRP: única responsabilidad — iniciar sesión con el token de Google.

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';

class LoginGoogleUseCase {
  final AuthPort _authPort;
  LoginGoogleUseCase(this._authPort);

  Future<({UserEntity user, String token})> execute(String credential) {
    return _authPort.loginWithGoogle(credential);
  }
}
