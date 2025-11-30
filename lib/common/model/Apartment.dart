// ------------------- نماذج البيانات (Models) -------------------
class Apartment {
  final String id;
  final String title;
  final String city;
  final double price;
  final String imageUrl;
  final double rating;
  final String description;
  final List<String> amenities;

  Apartment({
    required this.id,
    required this.title,
    required this.city,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.amenities,
  });
}
