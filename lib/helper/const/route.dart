import 'package:apartment_rental_system/features/rentel/Chat/controller/chatController.dart';
import 'package:apartment_rental_system/features/rentel/Chat/controller/chat_box_controller.dart';
import 'package:apartment_rental_system/features/rentel/Chat/screen/chatBoxScreen.dart';
import 'package:apartment_rental_system/features/rentel/Chat/screen/chatScreen.dart';
import 'package:apartment_rental_system/features/rentel/Notification/controller/notificationController.dart';
import 'package:apartment_rental_system/features/rentel/Notification/screen/notificationScreen.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/apartmentdetails.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/screen/incomingBookingsScreen.dart';
import 'package:apartment_rental_system/features/rentel/rentelWrapper/screen/rentalMainWrapper.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/screen/apartmentdetails.dart';
import 'package:apartment_rental_system/common/features/auth/screen/forgetPassword.dart';
import 'package:apartment_rental_system/common/features/auth/screen/login.dart';
import 'package:apartment_rental_system/common/features/auth/screen/newPassword.dart';
import 'package:apartment_rental_system/common/features/auth/screen/registerAccount.dart';
import 'package:apartment_rental_system/common/features/auth/screen/registerpersonalInf.dart';
import 'package:apartment_rental_system/features/tenant/mainwrapper/screen/mainwrapper.dart';
import 'package:apartment_rental_system/common/screen/verfiy_otp_email_page.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/screen/booking_details_page.dart';
import 'package:apartment_rental_system/common/features/onboarding/onboardingScreen.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/addApartment_view.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/editApartment_view.dart';
import 'package:apartment_rental_system/features/rentel/home/screen/rental_home_view.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/verfiy_password_requierd_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_email_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_language_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_password_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_phone_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_profile_page.dart';
import 'package:apartment_rental_system/features/tenant/settings/screen/edit_theme_page.dart';
import 'package:apartment_rental_system/common/features/splash/screen/splash.dart';
import 'package:apartment_rental_system/testuils/apartmentdetails.dart';
import 'package:apartment_rental_system/util/Binding/boookingdeatils.dart';
import 'package:apartment_rental_system/util/Binding/rentel/rentalHomeBinding.dart';
import 'package:apartment_rental_system/util/Binding/splashBinding.dart';
import 'package:apartment_rental_system/util/Middleware/authMiddleware.dart';
import 'package:apartment_rental_system/util/Binding/apartmetnrdetils.dart';
import 'package:apartment_rental_system/util/Binding/verify_password_binding.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: '/mainwrapper',
    page: () => const MainWrapper(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/rentel-mainwrapper',
    page: () => const RentalMainWrapper(),
    middlewares: [AuthMiddleware()],
    binding: BindingsBuilder(() {
      Get.put(NotificationController()); // حقن الكنترولر هنا
    }),
  ),

  GetPage(
    name: '/editprofilepage',
    page: () => EditProfilePage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(name: '/registerAccountScreen', page: () => const Registeraccount()),
  GetPage(
    name: '/registerProfileScreen',
    page: () => const Registerpersonalinf(),
  ),
  GetPage(name: '/loginScreen', page: () => const LoginScreen()),
  GetPage(name: '/newpasswordscreen', page: () => const Newpasswordscreen()),

  GetPage(
    name: '/editEmailPage',
    page: () => EditEmailPage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/editPhonePage',
    page: () => EditPhonePage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/editPasswordPage',
    page: () => EditPasswordPage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/themeSelectionPage',
    page: () => ThemeSelectionPage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(name: '/verfiyOtpEmailPage', page: () => VerfiyOtpEmailPage()),
  GetPage(name: '/forgetPasswordPage', page: () => ForgetPasswordScreen()),
  GetPage(
    name: '/apartment-details',
    page: () => ApartmentDetailsScreenTest(apartment: Get.arguments),
    binding: ApartmentDetailsBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/apartment-details-rental',
    page: () => ApartmentDetailsScreenRental(apartment: Get.arguments),
    binding: ApartmentDetailsBinding(),
    middlewares: [AuthMiddleware()],
  ),

  GetPage(
    name: '/authPasswordRequierdPage',
    page: () => AuthPasswordRequierdPage(),
    binding: VerifyPasswordBinding(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/languageSelectionCardPage',
    page: () => LanguageSelectionCardPage(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(name: '/onboardingScreen', page: () => OnboardingScreen()),
  GetPage(
    name: '/splash',
    page: () => SplashCinematicFull(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/bookingDetailsScreen',
    page: () => BookingDetailsScreen(),
    binding: BookingDetailsBinding(),
  ),
  GetPage(
    name: '/rental-home',
    page: () => MyApartmentsScreen(),
    bindings: [RentalHomeBinding()],
  ),
  GetPage(name: '/add', page: () => AddApartmentScreen()),
  GetPage(name: '/edit', page: () => EditApartmentScreen()),
  GetPage(name: '/rentel-booking', page: () => IncomingBookingsScreen()),
  GetPage(name: '/notificationScreen', page: () => NotificationScreen()),
  GetPage(
    name: '/chatScreen',
    page: () => ChatScreen(
      receiverId: Get.arguments['receiverId'],
      receiverName: Get.arguments['receiverName'],
      currentUserId: Get.arguments['currentUserId'],
    ),
    binding: BindingsBuilder(() {
      Get.put(ChatController());
    }),
  ),

  GetPage(
    name: '/chatBoxScreen',
    page: () => ChatBoxScreen(),
    binding: BindingsBuilder(() {
      Get.put(ChatBoxController());
    }),
  ),
];
