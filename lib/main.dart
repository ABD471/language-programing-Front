import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/features/auth/screen/login.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RentApp());
}

final List<Apartment> dummyApartments = [
  Apartment(
    id: '1',
    title: 'شقة فاخرة مطلة على البحر',
    city: 'اللاذقية',
    price: 150000,
    rating: 4.8,
    imageUrl:
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    description:
        'شقة واسعة مكونة من 3 غرف نوم وصالة كبيرة مع إطلالة بانورامية على البحر. قريبة من الأسواق والمطاعم.',
    amenities: ['واي فاي', 'تكييف', 'مطبخ مجهز', 'موقف سيارات'],
  ),
  Apartment(
    id: '2',
    title: 'استديو هادئ في وسط المدينة',
    city: 'دمشق',
    price: 85000,
    rating: 4.5,
    imageUrl:
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    description:
        'استديو عصري في منطقة الشعلان، قريب من الجامعات والمواصلات. مناسب للطلاب أو الموظفين.',
    amenities: ['تدفئة', 'انترنت', 'مصعد', 'أمن 24/7'],
  ),
  Apartment(
    id: '3',
    title: 'منزل ريفي للإجازات',
    city: 'بلودان',
    price: 200000,
    rating: 4.9,
    imageUrl:
        'https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    description:
        'فيلا صغيرة مع حديقة ومسبح خاص، جو رائع وهواء عليل. مثالية للعائلات.',
    amenities: ['مسبح', 'حديقة', 'شواية', 'مدفأة حطب'],
  ),
];

// ------------------- التطبيق الرئيسي -------------------
class RentApp extends StatelessWidget {
  const RentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق إيجار',
      theme: AppTheme.theme,
      // نجبر التطبيق على الاتجاه من اليمين لليسار (العربية)
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      home: const LoginScreen(),
    );
  }
}
