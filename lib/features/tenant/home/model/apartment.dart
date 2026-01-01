import 'package:apartment_rental_system/features/tenant/apartmetdetails/model/address.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/model/images.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/model/owner.dart';

class ApartmentTest {
  final int id;
  final String title;
  final String description;
  final String paymentInformation;
  final String price;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final int ownerId;
  final Address address;
  List<ApartmentImage> images;
  final Owner owner;

  ApartmentTest({
    required this.id,
    required this.title,
    required this.description,
    required this.paymentInformation,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.ownerId,
    required this.address,
    required this.images,
    required this.owner,
  });

  factory ApartmentTest.fromJson(Map<String, dynamic> json) {
    return ApartmentTest(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      paymentInformation: json['payment_information'] ?? '',
      price: json['price'] ?? '',
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: json['area'] ?? 0,
      ownerId: json['owner_id'] ?? 0,
      address: Address.fromJson(json['address'] ?? {}),
      images: (json['images'] as List? ?? [])
          .map((e) => ApartmentImage.fromJson(e))
          .toList(),
      owner: Owner.fromJson(json['owner'] ?? {}),
    );
  }
}
