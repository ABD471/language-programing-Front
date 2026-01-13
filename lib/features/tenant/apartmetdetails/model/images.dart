class ApartmentImage {
  final int id;
  final String url;

  ApartmentImage({required this.id, required this.url});

  factory ApartmentImage.fromJson(Map<String, dynamic> json) {
    return ApartmentImage(
      id: json['id'] ?? 0,
      url: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': url, 
    };
  }
}
