import 'dart:io';

import 'package:fruits_hub/features/add_product/domain/entities/review_entity.dart';

class ProductEntity {
  final String name;
  final String description;
  final num price;
  final File? image;
  String? imageUrl;
  final String code;
  final bool isFeatured;
  final bool isOrganic;
  final num reviews;
  final num rating;
  final num quantityOfKalories;
  final List<ReviewEntity> reviewEntity;
  final int expiratinsDateByMonths;

  ProductEntity({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.imageUrl,
    required this.code,
    required this.isFeatured,
    this.isOrganic = false,
    this.reviews = 0,
    this.rating = 0,
    required this.quantityOfKalories,
    required this.expiratinsDateByMonths,
    this.reviewEntity = const [],
  });
}
