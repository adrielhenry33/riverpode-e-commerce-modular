import 'package:arq_app/components/texto_form_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_providers.dart';
import '../states/auth_states.dart';

class RegistrationView extends ConsumerStatefulWidget {
  const RegistrationView({super.key});

  @override
  ConsumerState<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends ConsumerState<RegistrationView> {
  // Controllers locais como você prefere
  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _senhaController;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Escuta mudanças de estado para navegação ou alertas
    ref.listen<AuthStates>(registrationProvider, (previous, next) {
      if (next is AuthSuccess) context.go('/home');
      if (next is AuthError) _showError(next.errorMessage);
    });

    final state = ref.watch(registrationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _key,
          child: Column(
            children: [
              const Icon(
                Icons.storefront,
                color: Colors.deepOrangeAccent,
                size: 100,
              ),
              const SizedBox(height: 20),

              TextoFormComponent(
                controller: _nomeController,
                labelText: 'Nome Completo',
                icone: Icons.person,
                validator: (String? p1) {},
                isObscure: false,
                needIcon: false,
              ),
              const SizedBox(height: 15),

              TextoFormComponent(
                controller: _emailController,
                labelText: 'E-mail',
                icone: Icons.email,
                validator: (String? p1) {},
                isObscure: false,
                needIcon: false,
              ),
              const SizedBox(height: 15),

              TextoFormComponent(
                controller: _senhaController,
                labelText: 'Senha',
                icone: Icons.lock,
                isObscure: true,
                needIcon: true,
                validator: (String? p1) {},
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: state is AuthLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  minimumSize: const Size.fromHeight(55),
                ),
                child: state is AuthLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_key.currentState!.validate()) {
      ref
          .read(registrationProvider.notifier)
          .register(
            nome: _nomeController.text,
            email: _emailController.text,
            senha: _senhaController.text,
            sobrenome: '',
          );
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
