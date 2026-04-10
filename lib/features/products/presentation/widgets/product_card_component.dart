import 'package:arq_app/features/cart/data/models/cart_model.dart';
import 'package:arq_app/features/cart/presentation/viewmodel/cart_product_viewmodel.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart'; // IMPORTANTE: Usar Entity
import 'package:arq_app/features/products/presentation/providers/product_providers.dart';
import 'package:arq_app/features/products/presentation/view/pop_up_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Trocamos Modular por GoRouter

class ProductCardComponent extends ConsumerWidget {
  // Mudamos de ProductModel para ProductEntity para seguir o Domain-Driven Design
  final ProductEntity produto;

  const ProductCardComponent({super.key, required this.produto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaFavoritos = ref.watch(favoritesProvider);
    final isFavorite = listaFavoritos.contains(produto);

    final listaCarrinho = ref.watch(cartProvider);
    bool isOnCart = listaCarrinho.any((item) => item.produto.id == produto.id);

    final cartEnvio = CartProductModel(produto: produto, quantidade: 1);

    Color corContexto = Theme.of(context).colorScheme.outline.withOpacity(0.5);

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
                  // NAVEGAÇÃO: Usando GoRouter com o objeto 'extra'
                  context.push('/details', extra: produto);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    // Melhor usar Image.network direto
                    produto.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            produto.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${produto.price.toStringAsFixed(2)}', // Formatando o preço
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // Botão de Carrinho
              _buildActionButton(
                onTap: () {
                  isOnCart
                      ? ref.read(cartProvider.notifier).deleteProduct(cartEnvio)
                      : ref.read(cartProvider.notifier).addProduct(cartEnvio);
                },
                color: Colors.deepPurple,
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: isOnCart ? Colors.green : Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              // Botão de Favoritos
              _buildActionButton(
                onTap: () => ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(produto),
                color: Colors.grey.withOpacity(0.1),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              // Popup de mais opções
              PopUpComponent(produto: produto, showAllIcons: true),
            ],
          ),
        ],
      ),
    );
  }

  // Helper para manter o código limpo
  Widget _buildActionButton({
    required VoidCallback onTap,
    required Color color,
    required Widget icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
