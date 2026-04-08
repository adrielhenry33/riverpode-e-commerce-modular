import 'package:arq_app/app/routes/app_routes_names.dart';
import 'package:arq_app/app/view/details_view.dart';
import 'package:arq_app/app/view/home_view.dart';
import 'package:arq_app/features/auth/domain/entities/user_entities/user_entities.dart';
// Importações de rotas e providers
import 'package:arq_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:arq_app/features/auth/presentation/states/auth_states.dart';
import 'package:arq_app/features/auth/presentation/views/login_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutesNames.home,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == AppRoutesNames.login;

      if (authState is AuthInitial && !isLoggingIn) {
        return AppRoutesNames.login;
      }

      if (authState is AuthSuccess && isLoggingIn) {
        return AppRoutesNames.home;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutesNames.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutesNames.home,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: AppRoutesNames.detailProduct,
        builder: (context, state) {
          final produto = state.extra as UserEntities;
          return DetailsView(produto: produto);
        },
      ),
    ],
  );
});
