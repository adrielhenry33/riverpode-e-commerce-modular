import 'package:arq_app/features/products/domain/usecase/geteletronics_usecase.dart';
import 'package:arq_app/features/products/presentation/states/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifierViewModel extends StateNotifier<ProductState> {
  final GeteletronicsUsecase _geteletronicsUsecase;

  ProductNotifierViewModel(this._geteletronicsUsecase)
    : super(ProductInitial());

  Future<void> loadProducts({String categoria = ''}) async {
    try {
      state = ProductLoading();

      final result = await _geteletronicsUsecase.call();
      if (result.isEmpty) {
        state = ProductError("Nenhum produto encontrado");
      } else {
        state = ProductSuccess(result);
      }
    } catch (e) {
      state = ProductError("Falha ao carregar produtos: $e");
    }
  }
}
