import 'package:arq_app/features/auth/domain/usecases/delete_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:arq_app/features/auth/presentation/states/auth_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este Notifier so pode emitir e guardar coisas que sejam filhas de AuthStates
class AuthNotifier extends StateNotifier<AuthStates> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final RegisterUsecase registerUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  AuthNotifier(
    this.loginUsecase,
    this.logoutUsecase,
    this.registerUsecase,
    this.deleteAccountUsecase,
    this.resetPasswordUsecase,
  ) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      state = AuthLoading();
      final user = await loginUsecase.call(email, password);
      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await logoutUsecase.call();
      state = AuthInitial();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      state = AuthLoading();
      final user = await registerUsecase.call(email, password);
      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> delete(String email, String senha) async {
    try {
      state = AuthLoading();
      await deleteAccountUsecase.call();
      state = AuthInitial();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> resetePassword(String email) async {
    try {
      state = AuthLoading();
      await resetPasswordUsecase.call(email);
      state = AuthResetPasswordSucces(email);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
