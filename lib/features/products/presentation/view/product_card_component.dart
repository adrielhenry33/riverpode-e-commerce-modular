import 'package:arq_app/features/cart/data/models/cart_model.dart';
import 'package:arq_app/features/cart/presentation/viewmodel/cart_product_viewmodel.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/presentation/providers/product_providers.dart';
import 'package:arq_app/features/products/presentation/view/pop_up_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCardComponent extends ConsumerWidget {
  final ProductEntity produto;

  const ProductCardComponent({super.key, required this.produto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaFavoritos = ref.watch(favoritesProvider);
    final isFavorite = listaFavoritos.contains(produto);

    final listaCarrinho = ref.watch(cartProvider);
    bool isOnCart = listaCarrinho.any((item) => item.produto.id == produto.id);
    final cartEnvio = CartProductModel(produto: produto, quantidade: 1);

    Color corContexto = Theme.of(
      context,
    ).colorScheme.outline.withValues(alpha: 0.5);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: corContexto),
              ),
              child: GestureDetector(
                onTap: () {
                  Modular.to.pushNamed('/details', arguments: produto);
                },
                child: Image(
                  image: NetworkImage(produto.thumbnail),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            produto.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 4),

          Text(
            '\$${produto.price}',
            style: TextStyle(fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  isOnCart
                      ? ref.read(cartProvider.notifier).deleteProduct(cartEnvio)
                      : ref.read(cartProvider.notifier).addProduct(cartEnvio);
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.deepPurple,
                  ),
                  child: isOnCart
                      ? Icon(Icons.add_shopping_cart, color: Colors.green)
                      : Icon(Icons.add_shopping_cart, color: Colors.white),
                ),
              ),

              SizedBox(width: 10),

              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withValues(alpha: 0.1),
                ),
                child: IconButton(
                  onPressed: () {
                    ref
                        .read(favoritesProvider.notifier)
                        .toggleFavorite(produto);
                  },
                  icon: isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_outline),
                ),
              ),
              SizedBox(width: 10),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withValues(alpha: 0.1),
                ),
                child: PopUpComponent(produto: produto, showAllIcons: true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
