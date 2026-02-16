import 'dart:io';

import 'package:fruits_hub/features/add_product/data/models/review_model.dart';
import 'package:fruits_hub/features/add_product/domain/entities/add_product_entity.dart';

class ProductModel {
  final String name;
  final String description;
  final num price;
  final File? image;
  final String? imageUrl;
  final String code;
  final bool isFeatured;
  final bool isOrganic;
  final num reviews;
  final num rating;
  final num quantityOfKalories;
  final int expiratinsDateByMonths;
  final List<ReviewModel> reviewEntity;
  final num sellingCount;

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
    this.imageUrl,
    this.sellingCount = 0,
  });

  // FROM ENTITY
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
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
      imageUrl: entity.imageUrl,
      reviewEntity: entity.reviewEntity
          .map((review) => ReviewModel.fromEntity(review))
          .toList(),
      sellingCount: entity.sellingCount,
    );
  }

  // FROM FIRESTORE
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      image: null, // Firestore never returns File
      imageUrl: json['imageUrl'] as String?,
      code: json['code'] as String? ?? '',
      isFeatured: json['isFeatured'] as bool? ?? false,
      isOrganic: json['isOrganic'] as bool? ?? false,
      reviews: json['reviews'] as num? ?? 0,
      rating: json['rating'] as num? ?? 0,
      quantityOfKalories: json['quantityOfKalories'] as num? ?? 0,
      expiratinsDateByMonths: json['expiratinsDateByMonths'] as int? ?? 0,
      reviewEntity: (json['reviewEntity'] as List<dynamic>? ?? [])
          .map(
            (review) => ReviewModel.fromJson(Map<String, dynamic>.from(review)),
          )
          .toList(),
      sellingCount: json['sellingCount'] as num? ?? 0,
    );
  }

  // TO ENTITY
  ProductEntity toEntity() {
    return ProductEntity(
      name: name,
      description: description,
      price: price,
      image: image,
      imageUrl: imageUrl,
      code: code,
      isFeatured: isFeatured,
      isOrganic: isOrganic,
      reviews: reviews,
      rating: rating,
      quantityOfKalories: quantityOfKalories,
      expiratinsDateByMonths: expiratinsDateByMonths,
      reviewEntity: reviewEntity.map((review) => review.toEntity()).toList(),
      sellingCount: sellingCount,
    );
  }

  // TO FIRESTORE
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
      'reviewEntity': reviewEntity.map((e) => e.toJson()).toList(),
      'sellingCount': sellingCount,
    };
  }
}
