import 'dart:typed_data';

class Profile {
  String firstName;
  String lastName;
  DateTime dateOfBirth;

  Uint8List? profileImageBytes; // الصورة المحملة فعلياً

  Profile({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,

    this.profileImageBytes,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
    };
  }
}
