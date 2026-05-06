// application/usecases/register_usecase.dart
// SOLID-SRP: única responsabilidad — registrar un usuario nuevo.

import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';

class RegisterUseCase {
  final AuthPort _authPort;
  RegisterUseCase(this._authPort);

  Future<({UserEntity user, String token})> execute({
    required String email,
    required String password,
    required String username,
  }) {
    return _authPort.register(
      email: email,
      password: password,
      username: username,
    );
  }
}
