// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReviewEntity {
  final String userName;
  final String review;
  final String userImage;
  final num rating;
  final String? createdAt;
  final String? updatedAt;
  ReviewEntity({
    required this.userName,
    required this.review,
    required this.userImage,
    required this.rating,
    this.createdAt,
    this.updatedAt,
  });
}
