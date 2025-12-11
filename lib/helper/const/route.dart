import 'package:apartment_rental_system/features/apartmetdetails/screen/apartmentdetails.dart';
import 'package:apartment_rental_system/features/auth/screen/forgetPassword.dart';
import 'package:apartment_rental_system/features/auth/screen/login.dart';
import 'package:apartment_rental_system/features/auth/screen/newPassword.dart';
import 'package:apartment_rental_system/features/auth/screen/registerAccount.dart';
import 'package:apartment_rental_system/features/auth/screen/registerpersonalInf.dart';
import 'package:apartment_rental_system/features/mainwrapper/screen/mainwrapper.dart';
import 'package:apartment_rental_system/common/screen/verfiy_otp_email_page.dart';
import 'package:apartment_rental_system/features/settings/screen/verfiy_password_requierd_page.dart';
import 'package:apartment_rental_system/features/settings/screen/edit_email_page.dart';
import 'package:apartment_rental_system/features/settings/screen/edit_language_page.dart';
import 'package:apartment_rental_system/features/settings/screen/edit_password_page.dart';
import 'package:apartment_rental_system/features/settings/screen/edit_phone_page.dart';
import 'package:apartment_rental_system/features/settings/screen/edit_profile_page.dart';
import 'package:apartment_rental_system/features/settings/screen/edit_theme_page.dart';
import 'package:apartment_rental_system/util/binding/apartmetnrdetils.dart';
import 'package:apartment_rental_system/util/binding/verify_password_binding.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/mainwrapper', page: () => const MainWrapper()),
  GetPage(name: '/editprofilepage', page: () => EditProfilePage()),
  GetPage(name: '/registerAccountScreen', page: () => const Registeraccount()),
  GetPage(
    name: '/registerProfileScreen',
    page: () => const Registerpersonalinf(),
  ),
  GetPage(name: '/loginScreen', page: () => const LoginScreen()),
  GetPage(name: '/newpasswordscreen', page: () => const Newpasswordscreen()),

  GetPage(name: '/editEmailPage', page: () => EditEmailPage()),
  GetPage(name: '/editPhonePage', page: () => EditPhonePage()),
  GetPage(name: '/editPasswordPage', page: () => EditPasswordPage()),
  GetPage(name: '/themeSelectionPage', page: () => ThemeSelectionPage()),
  GetPage(name: '/verfiyOtpEmailPage', page: () => VerfiyOtpEmailPage()),
  GetPage(name: '/forgetPasswordPage', page: () => ForgetPasswordScreen()),
  GetPage(
    name: '/apartment-details',
    page: () => ApartmentDetailsScreen(apartment: Get.arguments),
    binding: ApartmentDetailsBinding(),
  ),

  GetPage(
    name: '/authPasswordRequierdPage',
    page: () => AuthPasswordRequierdPage(),
    binding: VerifyPasswordBinding(),
  ),
  GetPage(
    name: '/languageSelectionCardPage',
    page: () => LanguageSelectionCardPage(),
  ),
];
