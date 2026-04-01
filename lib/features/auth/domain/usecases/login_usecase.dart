import 'package:arq_app/features/auth/domain/entities/user_entities/user_entities.dart';
import 'package:arq_app/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final IAuthRepository _authRepository;
  LoginUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;
    
  Future<UserEntities> call(String email, String password) async {
    if (!email.contains('@') || email.isEmpty) {
      throw Exception('Formato de e-mail invalido');
    }
    if (password.length < 6) {
      throw Exception(
        'Passowod invávlido, a senha deve conter no minino 6 caracteres',
      );
    }
    return _authRepository.login(email, password);
  }
}
