// Tambahkan field sesuai kebutuhan jika API sudah mendukung get user.

class UserModel {
  final String id;
  final String? username;
  final String email;
  final bool? verified;
  final String? userRole;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    this.username,
    required this.email,
    this.verified,
    this.userRole,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'],
      email: json['email'] ?? '',
      verified: json['verified'],
      userRole: json['user_role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'verified': verified,
      'user_role': userRole,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, email: $email, verified: $verified, user_role: $userRole, created_at: $createdAt, updated_at: $updatedAt}';
  }
}
