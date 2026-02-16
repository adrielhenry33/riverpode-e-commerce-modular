import 'package:arq_app/app/components/card_user_component.dart';
import 'package:arq_app/app/models/user_model.dart';
import 'package:arq_app/app/viewmodels/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  final UserModel? user;
  const ProfileView({super.key, this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileView();
}

class _ProfileView extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final useProvider = ref.read(userViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        title: Text('Perfil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.orange[400],
                    radius: 50,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.deepPurple,
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
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                          border: Border.all(width: 3, color: Colors.white),
                        ),
                        child: Icon(Icons.edit, size: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),
              Text('Sugestões para você', style: TextStyle(fontSize: 25)),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardUserComponent(
                    iconData: Icons.redeem,
                    title: 'Ganhe 10% OFF!',
                    subtitle: 'Complete seu cadastro agora.',
                    textButton: 'Completar',
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
