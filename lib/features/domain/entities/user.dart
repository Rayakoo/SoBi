// Tambahkan field sesuai kebutuhan jika API sudah mendukung get user.

class User {
  final String id;
  final String username;
  final String email;
  final bool verified;
  final String userRole;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.verified,
    required this.userRole,
    required this.createdAt,
    required this.updatedAt,
  });
}
