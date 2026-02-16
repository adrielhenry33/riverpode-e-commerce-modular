import 'package:flutter/material.dart';

class UserAssetsComponent extends StatelessWidget {
  final IconData icon;
  final String texto;
  final String rota;

  const UserAssetsComponent({
    super.key,
    required this.icon,
    required this.texto,
    required this.rota,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurpleAccent[400], size: 30),
          SizedBox(width: 50),
          Text(texto, style: TextStyle(color: Colors.black, fontSize: 20)),
         
        ],
      ),
    );
  }
}
