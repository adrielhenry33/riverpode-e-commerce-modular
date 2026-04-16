import 'dart:async';

import 'package:arq_app/app/infraestructure/adapters/resilient_client_adapter.dart';
import 'package:arq_app/app/interfaces/client_http_interface.dart';
import 'package:arq_app/features/products/data/repository/product_by_category_impl.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/domain/repository/i_product_repository.dart';
import 'package:arq_app/features/products/domain/usecase/geteletronics_usecase.dart';
import 'package:arq_app/features/products/presentation/states/product_state.dart';
import 'package:arq_app/features/products/presentation/viewmodel/product_notifier_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientHttpProvider = Provider<ClientHttpInterface>((ref) {
  return ResilientClientAdapter();
});

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  final client = ref.watch(clientHttpProvider);
  return ProductByCategoryImpl(client);
});

final getElectronicsUseCaseProvider = Provider<GeteletronicsUsecase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GeteletronicsUsecase(repository);
});

final productNotifierProvider =
    StateNotifierProvider<ProductNotifierViewModel, ProductState>((ref) {
      final useCase = ref.watch(getElectronicsUseCaseProvider);
      final notifier = ProductNotifierViewModel(useCase);

      // Disparo automático do carregamento
      Future.microtask(() => notifier.loadProducts());

      return notifier;
    });

class FavoritesNotifier extends StateNotifier<List<ProductEntity>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(ProductEntity product) {
    if (state.any((p) => p.id == product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<ProductEntity>>((ref) {
      return FavoritesNotifier();
    });
