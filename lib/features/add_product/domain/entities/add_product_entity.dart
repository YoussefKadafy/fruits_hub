import 'dart:io';

class AddProductEntity {
  final String name;
  final String description;
  final num price;
  final File image;
  final String? imageUrl;
  final String code;
  final bool isFeatured;

  AddProductEntity({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.code,
    this.imageUrl,
    required this.isFeatured,
  });
}
