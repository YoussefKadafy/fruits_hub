import 'package:fruits_hub/features/add_product/domain/entities/review_entity.dart';

class ReviewModel {
  final String userName;
  final String review;
  final String userImage;
  final num rating;
  final String? createdAt;
  final String? updatedAt;

  ReviewModel({
    required this.userName,
    required this.review,
    required this.userImage,
    required this.rating,
    this.createdAt,
    this.updatedAt,
  });
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['userName'],
      review: json['review'],
      userImage: json['userImage'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      userName: entity.userName,
      review: entity.review,
      userImage: entity.userImage,
      rating: entity.rating,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'review': review,
      'userImage': userImage,
      'rating': rating,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
