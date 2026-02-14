import 'dart:io';

import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class AddProductModel {
  final String name;
  final String description;
  final num price;
  final File image;
  String? imageUrl;
  final String code;
  final bool isFeatured;
  final bool isOrganic;
  final num reviews;
  final num rating;
  final num quantityOfKalories;

  AddProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.code,
    required this.isFeatured,
    required this.isOrganic,
    required this.reviews,
    required this.rating,
    required this.quantityOfKalories,
  });
  factory AddProductModel.fromEntity(AddProductEntity entity) {
    final model = AddProductModel(
      name: entity.name,
      description: entity.description,
      price: entity.price,
      image: entity.image,
      code: entity.code,
      isFeatured: entity.isFeatured,
      isOrganic: entity.isOrganic,
      reviews: entity.reviews,
      rating: entity.rating,
      quantityOfKalories: entity.quantityOfKalories,
    );
    model.imageUrl = entity.imageUrl;
    return model;
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'code': code,
      'isFeatured': isFeatured,
      'isOrganic': isOrganic,
      'reviews': reviews,
      'rating': rating,
      'quantityOfKalories': quantityOfKalories,
    };
  }
}
