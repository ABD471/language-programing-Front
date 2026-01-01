class Owner {
  final int id;
  final String phone;
  final String email;
  final String role;
  final String status;
  final bool isVerified;

  Owner({
    required this.id,
    required this.phone,
    required this.email,
    required this.role,
    required this.status,
    required this.isVerified,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      isVerified: json['is_verified'] ?? false,
    );
  }
}
