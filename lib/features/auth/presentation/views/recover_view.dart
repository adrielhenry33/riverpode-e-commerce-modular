import 'dart:io';

import 'package:arq_app/components/texto_form_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecoverView extends StatefulWidget {
  const RecoverView({super.key});

  @override
  State<RecoverView> createState() => _RecoverViewState();
}

class _RecoverViewState extends State<RecoverView> {
  final _key = GlobalKey<FormState>();

 

  @override
  Widget build(BuildContext context) {
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
                    controller: viewmodel.controller,
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
                          final result = await viewmodel.resetPassword();
                          if (!result) {
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  if (Platform.isAndroid) {
                                    return AlertDialog(
                                      title: Text('Usuario não cadastrado'),
                                      content: Text(
                                        'Email  incorreto, tente novamente ${viewmodel.exceptionMessage}',
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
                                      content: Text(viewmodel.exceptionMessage),
                                      actions: [
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          child: Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              );
                            }
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
