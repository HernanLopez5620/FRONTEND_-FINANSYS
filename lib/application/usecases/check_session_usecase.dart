// application/usecases/check_session_usecase.dart
// SOLID-SRP: única responsabilidad — verificar que la sesión siga siendo la activa.

import '../../domain/ports/auth_port.dart';

class CheckSessionUseCase {
  final AuthPort _authPort;
  CheckSessionUseCase(this._authPort);

  Future<void> execute() => _authPort.checkSession();
}
