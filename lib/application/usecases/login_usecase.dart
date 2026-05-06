// application/usecases/login_usecase.dart
// SOLID-SRP: única responsabilidad — autenticar al usuario.

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';

class LoginUseCase {
  final AuthPort _authPort;
  LoginUseCase(this._authPort);

  Future<({UserEntity user, String token})> execute({
    required String email,
    required String password,
  }) {
    return _authPort.login(email: email, password: password);
  }
}
