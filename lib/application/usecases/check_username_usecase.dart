// application/usecases/check_username_usecase.dart
import '../../domain/ports/auth_port.dart';

class CheckUsernameUseCase {
  final AuthPort _authPort;
  CheckUsernameUseCase(this._authPort);

  Future<({bool disponible, String msg})> execute(String username) {
    return _authPort.checkUsername(username);
  }
}
