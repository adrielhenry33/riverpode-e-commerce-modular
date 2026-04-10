import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/domain/repository/i_product_repository.dart';

class GeteletronicsUsecase {
  final IProductRepository repository;

  GeteletronicsUsecase(this.repository);

  Future<List<ProductEntity>> call() async {
    final results = await Future.wait([
      repository.getProductByCategory('smartphones'),
      repository.getProductByCategory('laptops'),
      repository.getProductByCategory('tablets'),
    ]);

    return results.expand((list) => list).toList();
  }
}
