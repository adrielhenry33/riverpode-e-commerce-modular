import 'package:arq_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:arq_app/features/auth/presentation/states/auth_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthStates> {
  final LoginUsecase loginUsecase;

  AuthNotifier(this.loginUsecase) : super(null);
}
