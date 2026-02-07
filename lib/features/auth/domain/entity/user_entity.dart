class UserEntity {
  final String name;
  final String email;
  final String userId;
  final String role; // 👈 جديد

  UserEntity({
    required this.name,
    required this.email,
    required this.userId,
    required this.role,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'userId': userId,
    'role': role, // 👈 يتخزن في Firestore
  };

  factory UserEntity.fromMap(Map<String, dynamic> map) => UserEntity(
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    userId: map['userId'] ?? '',
    role: map['role'] ?? 'user', // 👈 default
  );
}
