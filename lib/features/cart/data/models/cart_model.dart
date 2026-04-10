import 'package:arq_app/features/products/domain/entities/product_entity.dart';

class CartProductModel {
  final ProductEntity produto;
  final int quantidade;

  CartProductModel({required this.produto, required this.quantidade});

  CartProductModel copyWith({int? quantidade}) {
    return CartProductModel(
      produto: produto,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}
