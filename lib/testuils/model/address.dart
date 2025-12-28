class Address {
  final int id;
  final String city;
  final String longitude;
  final String latitude;

  Address({
    required this.id,
    required this.city,
    required this.longitude,
    required this.latitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? 0,
      city: json['city'] ?? '',
      longitude: json['longitude']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? '',
    );
  }
}
