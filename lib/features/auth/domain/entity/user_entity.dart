class UserEntity {
  final String name;
  final String email;
  final String userId;

  UserEntity({required this.name, required this.email, required this.userId});

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'userId': userId,
  };
}
