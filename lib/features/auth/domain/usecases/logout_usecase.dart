import 'package:arq_app/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final IAuthRepository _authRepository;
  LogoutUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  Future<void> call() async {
    return _authRepository.logout();
  }
}
