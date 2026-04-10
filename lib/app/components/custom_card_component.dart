import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCardComponent extends StatelessWidget {
  final String urlImagemFundo;
  final String urlProduto;
  final String categoria;
  final String fraseEfeito;
  final double height;
  final double width;
  final double left;
  final double right;
  final double bottom;
  final String titulo;
  final String nomeCategoria;

  const CustomCardComponent({
    super.key,
    required this.urlImagemFundo,
    required this.urlProduto,
    required this.categoria,
    required this.fraseEfeito,
    required this.height,
    required this.width,
    required this.bottom,
    required this.left,
    required this.right,
    required this.titulo,
    required this.nomeCategoria,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/products-list/$nomeCategoria/$titulo');
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(urlImagemFundo),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(15),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      categoria,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      fraseEfeito,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'MontSerrat',
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: bottom,
                left: left,
                right: right,
                child: Image(
                  image: AssetImage(urlProduto),
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
