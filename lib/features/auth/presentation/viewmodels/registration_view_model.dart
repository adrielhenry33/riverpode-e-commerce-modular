import 'package:arq_app/features/auth/domain/entities/user_entities/user_entities.dart';
import 'package:arq_app/features/auth/presentation/states/auth_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<AuthStates> {
  RegistrationNotifier() : super(AuthInitial());

  Future<void> register({
    required String nome,
    required String email,
    required String senha,
    required String sobrenome,
  }) async {
    state = AuthLoading();

    try {
      await Future.delayed(const Duration(seconds: 2));

      final user = UserEntities(
        name: nome,
        email: email,
        nickName: sobrenome,
        picture: null,
      );
      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError("Falha no cadastro: $e");
    }
  }
}
