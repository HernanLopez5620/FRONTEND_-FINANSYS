// application/usecases/update_profile_usecase.dart
import '../../domain/entities/user_entity.dart';
import '../../domain/ports/auth_port.dart';

class UpdateProfileUseCase {
  final AuthPort _authPort;
  UpdateProfileUseCase(this._authPort);

  Future<UserEntity> execute({String? username, String? password}) {
    return _authPort.updateProfile(username: username, password: password);
  }
}
