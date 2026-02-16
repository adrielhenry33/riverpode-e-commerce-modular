import 'package:arq_app/app/components/custom_bottom_app_bar_component.dart';
import 'package:arq_app/app/components/custom_switch_widget.dart';
import 'package:arq_app/app/components/product_card_component.dart';
import 'package:arq_app/providers/categorias_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsListView extends ConsumerWidget {
  final String nomeCategoria;
  final String titulo;

  const ProductsListView({
    super.key,
    required this.nomeCategoria,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productsByCategoryProvider(nomeCategoria));

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 30)),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list_rounded, size: 30),
          ),
          SizedBox(width: 10),

          CustomSwitchWidget(),
          SizedBox(width: 10),
        ],
      ),

      body: productState.when(
        data: (produtos) {
          return GridView.builder(
            itemCount: produtos.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return ProductCardComponent(produto: produtos[index]);
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sem conexão com Internet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'tente novamente',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Icon(Icons.error_outline, size: 50, color: Colors.red),
              ],
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}
