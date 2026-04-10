import 'package:arq_app/features/cart/data/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProductViewmodel extends StateNotifier<List<CartProductModel>> {
  CartProductViewmodel() : super([]);

  void addProduct(CartProductModel produto) {
    final exists = state.any((p) => p.produto.id == produto.produto.id);

    if (exists) {
      final ocurrence = state.indexWhere(
        (p) => p.produto.id == produto.produto.id,
      );

      List<CartProductModel> listAux = [...state];

      final copia = listAux[ocurrence].copyWith(
        quantidade: listAux[ocurrence].quantidade + 1,
      );

      listAux[ocurrence] = copia;
      state = listAux;
    } else {
      state = [...state, produto.copyWith(quantidade: 1)];
    }
  }

  void deleteProduct(CartProductModel produto) {
    final exists = state.any((p) {
      return p.produto.id == produto.produto.id;
    });

    if (exists) {
      final ocurrence = state.indexWhere(
        (p) => p.produto.id == produto.produto.id,
      );

      List<CartProductModel> listAux = [...state];

      final copia = listAux[ocurrence].copyWith(
        quantidade: listAux[ocurrence].quantidade - 1,
      );

      if (copia.quantidade < 1) {
        listAux.removeAt(ocurrence);
        state = listAux;
      } else {
        listAux[ocurrence] = copia;
        state = listAux;
      }
    }
  }

  void deleteAll() {
    if (state.isNotEmpty) {
      state = [];
    }
  }

  int getQtdProduto(CartProductModel produto) {
    final result = state.firstWhere((p) => p.produto.id == produto.produto.id);
    return result.quantidade;
  }
}

//cerebro           //o que sera retornado
final cartProvider =
    StateNotifierProvider<CartProductViewmodel, List<CartProductModel>>(
      (ref) => CartProductViewmodel(),
    );

final findOcurrenceProvider = Provider.family<int, int>((ref, id) {
  final provider = ref.watch(cartProvider);

  try {
    final ocurrence = provider.firstWhere((p) => p.produto.id == id);
    return ocurrence.quantidade;
  } catch (e) {
    return 0;
  }
});
