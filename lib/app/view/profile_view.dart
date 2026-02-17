import 'package:arq_app/app/components/card_user_component.dart';
import 'package:arq_app/app/components/custom_bottom_app_bar_component.dart';
import 'package:arq_app/app/components/user_assets_component.dart';
import 'package:arq_app/app/models/user_model.dart';
import 'package:arq_app/app/viewmodels/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  final UserModel? user;
  final bool isLogged;
  const ProfileView({super.key, this.user, this.isLogged = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileView();
}

class _ProfileView extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final useProvider = ref.read(userViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Perfil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange[400],
                        radius: 50,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.deepPurpleAccent,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,

                        child: GestureDetector(
                          onTap: () async {
                            await ref
                                .read(userViewModelProvider.notifier)
                                .setProfilePick();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: Colors.white),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 15),

                  widget.isLogged
                      ? Column(
                          children: [
                            Text(
                              'Adriel Henry Dias Barbosa',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'adrielhenrydb@gmail.com',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),

              SizedBox(height: 30),
              const Text('Sugestões para você', style: TextStyle(fontSize: 20)),
              SizedBox(height: 5),

              CardUserComponent(
                iconData: Icons.redeem,
                title: 'Ganhe 10% OFF!',
                subtitle: 'Complete seu cadastro agora.',
                textButton: 'Completar',
                color: Colors.orange,
              ),

              SizedBox(height: 30),

              UserAssetsComponent(
                icon: Icons.inventory,
                texto: 'Meus Pedidos',
                rota: '/pedidos',
              ),
              Divider(color: Colors.black87),

              SizedBox(height: 20),

              UserAssetsComponent(
                icon: Icons.place,
                texto: 'Meus Endereços',
                rota: '/endereços',
              ),

              Divider(color: Colors.black87),

              SizedBox(height: 15),

              UserAssetsComponent(
                icon: Icons.favorite,
                texto: 'Favoritos',
                rota: '/favoritos',
              ),
              Divider(color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
