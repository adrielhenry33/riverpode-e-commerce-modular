import '../repository/auth_repository.dart';

class DeleteAccountUsecase {
  final IAuthRepository _authRepository;

  DeleteAccountUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

    
  Future<void> call() async {
    return await _authRepository.delete();
  }
}
