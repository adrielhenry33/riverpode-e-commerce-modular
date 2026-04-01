import 'dart:io';

import 'package:arq_app/app/components/texto_form_component.dart';
import 'package:arq_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:arq_app/features/auth/presentation/states/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _showErrorDialog(BuildContext context, String message) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro ao Logar'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Erro ao Logar'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthStates>(authNotifierProvider, (previous, next) {
      if (next is AuthSuccess) {
        context.go('/home');
      } else if (next is AuthError) {
        _showErrorDialog(context, next.errorMessage);
      }
    });

    // 2. Assiste o estado para reagir na UI (Loading/Botão)
    final state = ref.watch(authNotifierProvider);

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final String loginImage = isDarkMode
        ? 'images/login_dark.png'
        : 'images/login_light.png';

    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.surface,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo e Título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        size: 50,
                        color: Colors.deepOrangeAccent,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'FakeStore',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Image(image: AssetImage(loginImage)),
                  const SizedBox(height: 20),

                  // Campo de Email
                  TextoFormComponent(
                    controller: emailController,
                    labelText: 'email',
                    icone: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    isObscure: false,
                    needIcon: false,
                  ),

                  const SizedBox(height: 15),

                  // Campo de Senha
                  TextoFormComponent(
                    controller: senhaController,
                    labelText: 'password',
                    icone: Icons.lock_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    isObscure: true,
                    needIcon: true,
                  ),

                  const SizedBox(height: 5),

                  // Esqueci minha senha
                  GestureDetector(
                    onTap: () => context.push('/recover'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Esqueceu sua senha? ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Botão de Login Reativo
                  ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null // Desabilita o clique enquanto carrega
                        : () {
                            if (_key.currentState!.validate()) {
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .login(
                                    emailController.text.trim(),
                                    senhaController.text.trim(),
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.deepOrangeAccent,
                      padding: const EdgeInsets.all(16),
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state is AuthLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () => context.push('/register'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Ainda não é membro?'),
                        SizedBox(width: 5),
                        Text(
                          'Cadastre-se',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
