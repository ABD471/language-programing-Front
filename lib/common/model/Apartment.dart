class Apartment {
  final String? id;
  final String? title;
  final String? city;
  final double? price;

  final String? imageUrl;
  final List<String>? extraImages;

  final double? rating;
  final int? reviewsCount;

  final String? description;
  final List<String>? amenities;

  // بيانات الاتصال
  final String? phoneNumber;

  // الموقع الجغرافي
  final double? latitude;
  final double? longitude;
  final String? location;
  // الحجز
  final List<DateTime>? bookedDates;
  final List<String>? bookedDatesString;

  Apartment({
    this.location,
    this.id,
    this.title,
    this.city,
    this.price,
    this.imageUrl,
    this.extraImages,
    this.rating,
    this.reviewsCount,
    this.description,
    this.amenities,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.bookedDates,
    this.bookedDatesString,
  });

  // ----------------------
  // fromJson
  // ----------------------
  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      location: json["location"],
      title: json['title'],
      city: json['city'],
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'],
      extraImages: json['extraImages'] != null
          ? List<String>.from(json['extraImages'])
          : null,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviewsCount'],
      description: json['description'],
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : null,
      phoneNumber: json['phoneNumber'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      bookedDates: json['bookedDates'] != null
          ? (json['bookedDates'] as List).map((d) => DateTime.parse(d)).toList()
          : null,
      bookedDatesString: json['bookedDatesString'] != null
          ? List<String>.from(json['bookedDatesString'])
          : null,
    );
  }

  // ----------------------
  // toJson
  // ----------------------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'city': city,
      'price': price,
      'imageUrl': imageUrl,
      'extraImages': extraImages,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'description': description,
      'amenities': amenities,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'bookedDates': bookedDates
          ?.map((date) => date.toIso8601String())
          .toList(),
      'bookedDatesString': bookedDatesString,
    };
  }
}
