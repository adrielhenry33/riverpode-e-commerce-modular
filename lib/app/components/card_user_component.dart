import 'package:flutter/material.dart';

class CardUserComponent extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;
  final String textButton;
  final Color color;

  const CardUserComponent({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.textButton,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 250,
      child: Card(
        elevation: 4,

        color: color,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
          ),
          child: Row(
            children: [
              Icon(iconData, color: Colors.white, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 5,),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                        ),
                        onPressed: () {},
                        color: Colors.white,
                        child: Text(
                          textButton,
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
