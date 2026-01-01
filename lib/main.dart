import 'dart:async';
import 'package:apartment_rental_system/common/features/Notification/controller/notificationController.dart';
import 'package:apartment_rental_system/common/features/settings/controller/editlang_theme_controller.dart';
import 'package:apartment_rental_system/helper/const/route.dart';
import 'package:apartment_rental_system/localization/translate.dart';
import 'package:apartment_rental_system/util/service/authservice.dart';
import 'package:apartment_rental_system/util/service/location_controller.dart';
import 'package:apartment_rental_system/util/service/notification_service.dart';
import 'package:apartment_rental_system/util/service/pusherService.dart';

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

  storage = FlutterSecureStorage(aOptions: getAndroidOptions());
  await AuthService.loadToken();

  sharedPreferences = await SharedPreferences.getInstance();
  final Settings = Get.put(EditlangThemeController(), permanent: true);
  await Settings.load();
  Get.put(NotificationController(), permanent: true);
  await Get.putAsync<NotificationService>(
    () async => await NotificationService().init(),
  );
  locationCtrl = Get.put(LocationController());
  Get.put(PusherService(), permanent: true);
  runApp(const RentApp());
}

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
            title: 'app_name'.tr,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            locale: Locale(settings.language.value),
            

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
