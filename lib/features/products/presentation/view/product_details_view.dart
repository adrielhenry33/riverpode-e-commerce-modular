import 'package:arq_app/features/cart/data/models/cart_model.dart';
import 'package:arq_app/features/cart/presentation/providers/cart_providers.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsView extends ConsumerWidget {
  final ProductEntity produto;

  const ProductDetailsView({super.key, required this.produto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((p) => p.id == produto.id);

    final cart = ref.watch(cartProvider);
    final isOnCart = cart.any((item) => item.produto.id == produto.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : null,
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggleFavorite(produto),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Galeria de Imagens
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: produto.images.length,
                itemBuilder: (context, index) =>
                    Image.network(produto.images[index], fit: BoxFit.contain),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${produto.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Descrição",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    produto.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // Botão de Ação
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final item = CartProductModel(
                          produto: produto,
                          quantidade: 1,
                        );
                        final notifier = ref.read(cartProvider.notifier);
                        isOnCart
                            ? notifier.deleteProduct(item)
                            : notifier.addProduct(item);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOnCart
                            ? Colors.redAccent
                            : Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      icon: Icon(
                        isOnCart
                            ? Icons.remove_shopping_cart
                            : Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      label: Text(
                        isOnCart
                            ? "Remover do Carrinho"
                            : "Adicionar ao Carrinho",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
