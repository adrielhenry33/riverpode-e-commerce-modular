import 'package:arq_app/app/components/product_card_component.dart';
import 'package:arq_app/features/products/presentation/providers/product_providers.dart';
import 'package:arq_app/features/products/presentation/states/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsListView extends ConsumerWidget {
  final String titulo;

  const ProductsListView({super.key, required this.titulo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: switch (state) {
        ProductInitial() => const SizedBox.shrink(),
        ProductLoading() => const Center(
          child: CircularProgressIndicator(color: Colors.deepOrangeAccent),
        ),
        ProductError(message: final errorMsg) => _buildError(ref, errorMsg),
        ProductSuccess(products: final lista) => _buildGrid(lista),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildGrid(List products) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) =>
          ProductCardComponent(produto: products[index]),
    );
  }

  Widget _buildError(WidgetRef ref, String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 60, color: Colors.grey),
          Text(msg, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () =>
                ref.read(productNotifierProvider.notifier).loadProducts(),
            child: const Text("Tentar novamente"),
          ),
        ],
      ),
    );
  }
}
