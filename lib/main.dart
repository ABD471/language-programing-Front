import 'dart:async';
import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/features/tenant/settings/controller/editlang_theme_controller.dart';
import 'package:apartment_rental_system/helper/const/route.dart';
import 'package:apartment_rental_system/localization/translate.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:apartment_rental_system/util/service/location_controller.dart';
import 'package:apartment_rental_system/util/service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

late LocationController locationCtrl;
late SharedPreferences sharedPreferences;
late FlutterSecureStorage storage;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  await Firebase.initializeApp();

  await Get.putAsync(() => NotificationService().init(), permanent: true);
  storage = FlutterSecureStorage(aOptions: getAndroidOptions());
  await AuthService.loadToken();
  sharedPreferences = await SharedPreferences.getInstance();
  Get.put(EditlangThemeController(), permanent: true);
  locationCtrl = Get.put(LocationController());
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
    final settings = Get.find<EditlangThemeController>();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(() {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'تطبيق إيجار',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            locale: Locale(settings.language.value),
            fallbackLocale: const Locale('ar'),
            translations: Translate(),
            builder: (context, child) {
              return Directionality(
                textDirection: settings.language.value == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child!,
              );
            },
            getPages: routes,
            initialRoute: '/splash',
          );
        });
      },
    );
  }
}
