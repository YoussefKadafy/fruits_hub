import 'dart:io';

class AddProductEntity {
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

  AddProductEntity({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.isOrganic = false,
    this.reviews = 0,
    this.rating = 0,
    required this.code,
    this.imageUrl,
    required this.isFeatured,
    required this.quantityOfKalories,
  });
}
