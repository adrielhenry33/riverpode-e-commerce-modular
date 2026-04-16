import 'dart:io';

import 'package:arq_app/components/texto_form_component.dart';
import 'package:arq_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecoverView extends ConsumerStatefulWidget {
  const RecoverView({super.key});

  @override
  ConsumerState<RecoverView> createState() => _RecoverViewState();
}

class _RecoverViewState extends ConsumerState<RecoverView> {
  final _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(authNotifierProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Infome seu e-mail abaixo e enviarimos um link para trocar sua senha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 15),
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
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushReplacementNamed('/');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Voltar a tela de login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await notifier.resetPasswordUsecase(
                            emailController.text.trim(),
                          );
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                if (Platform.isAndroid) {
                                  return AlertDialog(
                                    title: Text('Usuario não cadastrado'),
                                    content: Text(
                                      'Email  incorreto, tente novamente ',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                } else {
                                  return CupertinoAlertDialog(
                                    title: Text('Usuario não cadastrado'),
                                    content: Text('Favor cadastrar um usuario'),
                                    actions: [
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        child: Text('OK'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          } else {
                            Modular.to.pushReplacementNamed('/');
                          }
                        }
                      },
                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text('Enviar link'),
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
