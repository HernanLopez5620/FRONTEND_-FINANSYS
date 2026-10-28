// application/usecases/update_tema_usecase.dart
import '../../domain/ports/auth_port.dart';

class UpdateTemaUseCase {
  final AuthPort _authPort;
  UpdateTemaUseCase(this._authPort);

  Future<void> execute(String tema) => _authPort.updateTema(tema);
}
