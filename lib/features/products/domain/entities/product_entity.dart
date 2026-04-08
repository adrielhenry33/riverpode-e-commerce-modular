import 'package:arq_app/features/products/domain/entities/product_dimensions_entity.dart';
import 'package:arq_app/features/products/domain/entities/product_information_entity.dart';
import 'package:arq_app/features/products/domain/entities/product_review_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final List<String> images;
  final String brand;
  final String sku;
  final int weight;
  final ProductDimensionsEntity dimension;
  final List<ProductReviewEntity> reviews;
  final ProductInformationEntity information;
  final String thumbnail;

  const ProductEntity({
    required this.brand,
    required this.sku,
    required this.weight,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.description,
    required this.category,
    required this.images,
    required this.dimension,
    required this.reviews,
    required this.information,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id];
}
