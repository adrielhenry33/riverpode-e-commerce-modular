import 'package:arq_app/app/interfaces/client_http_interface.dart';
import 'package:arq_app/features/products/data/models/product_model.dart';
import 'package:arq_app/features/products/domain/entities/product_entity.dart';
import 'package:arq_app/features/products/domain/repository/i_product_repository.dart';

class ProductByCategoryImpl extends IProductRepository {
  final ClientHttpInterface _client;
  ProductByCategoryImpl(this._client);

  @override
  Future<List<ProductEntity>> getProductByCategory(String categoria) async {
    final response = await _client.get(
      'https://dummyjson.com/products/category/$categoria',
    );

    return _parseProducts(response);
  }

  List<ProductEntity> _parseProducts(dynamic responseBody) {
    if (responseBody is Map && responseBody.containsKey('products')) {
      final List list = responseBody['products'];
      return list.map((item) => ProductModel.fromJson(item)).toList();
    }
    return [];
  }
}
