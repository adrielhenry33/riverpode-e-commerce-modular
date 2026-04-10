import 'package:arq_app/components/texto_form_component.dart';
import 'package:arq_app/app/viewmodels/registrarion_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final viewmodel = Modular.get<RegistrarionViewmodel>();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    viewmodel.emailController.dispose();
    viewmodel.senhaController.dispose();
    viewmodel.nomeController.dispose();
    super.dispose();
  }

  void showErrorDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro ao cadastrar usuário'),
          content: Text(viewmodel.exceptionMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.canvasColor;

    return SafeArea(
      child: Scaffold(
        backgroundColor: color,
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(
            'FakeStore',

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,

          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.storefront,
                        color: Colors.deepOrangeAccent,
                        size: 100,
                      ),
                      SizedBox(height: 15),
                      Title(
                        color: color,
                        child: Text(
                          'Crie sua Conta',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      TextoFormComponent(
                        controller: viewmodel.nomeController,
                        labelText: 'Nome',
                        icone: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Obrigatorio';
                          }
                          return null;
                        },
                        isObscure: false,
                        needIcon: false,
                      ),

                      SizedBox(height: 15),

                      TextoFormComponent(
                        controller: viewmodel.emailController,
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
                      SizedBox(height: 15),

                      TextoFormComponent(
                        controller: viewmodel.senhaController,
                        labelText: 'password',
                        icone: Icons.lock_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Obrigatório';
                          }
                          return null;
                        },
                        isObscure: true,
                        needIcon: true,
                      ),

                      SizedBox(height: 15),

                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            final result = await viewmodel.signIn();
                            if (result) {
                              Modular.to.pushReplacementNamed('/home');
                            } else {
                              showErrorDialog();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: Colors.deepOrangeAccent,
                          padding: EdgeInsets.all(16),
                          textStyle: TextStyle(color: Colors.white),
                          minimumSize: Size.fromHeight(55),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),

                      SizedBox(height: 15),

                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamedAndRemoveUntil('/home', (route)=>false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ja é membro?'),
                            SizedBox(width: 5),
                            Text(
                              'Faça login',
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
        ),
      ),
    );
  }
}
