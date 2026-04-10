import 'package:arq_app/app/Services/resilient_client_adapter.dart';
import 'package:arq_app/app/interfaces/client_http_interface.dart'; // Teu client resiliente
import 'package:arq_app/features/products/data/repository/product_by_category_impl.dart';
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
      return ProductNotifierViewModel(useCase);
    });
