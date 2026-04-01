import 'package:arq_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:arq_app/features/auth/domain/repository/auth_repository.dart';
import 'package:arq_app/features/auth/domain/usecases/delete_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:arq_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:arq_app/features/auth/presentation/states/auth_states.dart';
import 'package:arq_app/features/auth/presentation/viewmodels/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) => AuthRepositoryImpl(FirebaseAuth.instance),
);

//UserCases Providers
final loginUsecaseProvider = Provider(
  (ref) => LoginUsecase(authRepository: ref.watch(authRepositoryProvider)),
);
final logoutUsecaseProvider = Provider(
  (ref) => LogoutUsecase(authRepository: ref.watch(authRepositoryProvider)),
);
final registerUsecaseProvider = Provider(
  (ref) => RegisterUsecase(authRepository: ref.watch(authRepositoryProvider)),
);
final deleteAccountUsecaseProvider = Provider(
  (ref) =>
      DeleteAccountUsecase(authRepository: ref.watch(authRepositoryProvider)),
);
final resetPasswordUsecaseProvider = Provider(
  (ref) =>
      ResetPasswordUsecase(authRepository: ref.watch(authRepositoryProvider)),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthStates>((
  ref,
) {
  return AuthNotifier(
    ref.watch(loginUsecaseProvider),
    ref.watch(logoutUsecaseProvider),
    ref.watch(registerUsecaseProvider),
    ref.watch(deleteAccountUsecaseProvider),
    ref.watch(resetPasswordUsecaseProvider),
  );
});
