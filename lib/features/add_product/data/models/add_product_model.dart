import 'dart:io';

import 'package:fruits_hub/features/add_product/data/models/review_model.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class ProductModel {
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
  final int expiratinsDateByMonths;
  final List<ReviewModel> reviewEntity;

  ProductModel({
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
    required this.expiratinsDateByMonths,
    required this.reviewEntity,
  });
  factory ProductModel.fromEntity(ProductEntity entity) {
    final model = ProductModel(
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
      expiratinsDateByMonths: entity.expiratinsDateByMonths,
      reviewEntity: entity.reviewEntity
          .map((review) => ReviewModel.fromEntity(review))
          .toList(),
    );
    model.imageUrl = entity.imageUrl;
    return model;
  }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: File(json['image']), // Assuming the image is stored as a file path
      code: json['code'],
      isFeatured: json['isFeatured'],
      isOrganic: json['isOrganic'],
      reviews: json['reviews'],
      rating: json['rating'],
      quantityOfKalories: json['quantityOfKalories'],
      expiratinsDateByMonths: json['expiratinsDateByMonths'],
      reviewEntity: (json['reviewEntity'] as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList(),
    );
  }
  ProductEntity toEntity() {
    return ProductEntity(
      name: name,
      description: description,
      price: price,
      image: image,
      code: code,
      isFeatured: isFeatured,
      isOrganic: isOrganic,
      reviews: reviews,
      rating: rating,
      quantityOfKalories: quantityOfKalories,
      expiratinsDateByMonths: expiratinsDateByMonths,
      reviewEntity: reviewEntity.map((review) => review.toEntity()).toList(),
    );
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
      'expiratinsDateByMonths': expiratinsDateByMonths,
      'reviewEntity': reviewEntity,
    };
  }
}
