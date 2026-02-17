import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                if (Modular.to.path != '/') {
                  Modular.to.pushNamed('/');
                }
              },
              icon: Icon(
                Icons.home_outlined,
                fill: 0,
                color: Colors.deepPurpleAccent,
              ),
            ),
            IconButton(
              onPressed: () {
                if (Modular.to.path != '/carrinho') {
                  Modular.to.pushNamed('/carrinho');
                }
              },
              icon: Icon(
                Icons.shopping_cart_checkout_outlined,
                color: Colors.deepPurpleAccent,
              ),
            ),
            IconButton(
              onPressed: () {
                if (Modular.to.path != '/favoritos') {
                  Modular.to.pushNamed('/favoritos');
                }
              },
              icon: Icon(
                CupertinoIcons.compass,
                fill: 0,
                color: Colors.deepPurpleAccent,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Modular.to.path != '/profile') {
                  Modular.to.pushNamed('/profile');
                }
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurple,
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Perfil',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
