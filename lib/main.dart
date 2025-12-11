import 'dart:async';
import 'dart:math';
import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/features/auth/screen/login.dart';
import 'package:apartment_rental_system/features/mainwrapper/screen/mainwrapper.dart';
import 'package:apartment_rental_system/features/settings/controller/editLangauegeController.dart';
import 'package:apartment_rental_system/features/settings/controller/editThemeController.dart';
import 'package:apartment_rental_system/localization/translate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apartment_rental_system/helper/const/route.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

late SharedPreferences sharedPreferences;
late FlutterSecureStorage storage;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  storage = FlutterSecureStorage(aOptions: getAndroidOptions());
  sharedPreferences = await SharedPreferences.getInstance();
  Get.put(ThemeController());
  Get.put(LanguageController());

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
    final theme = Get.find<ThemeController>();
    final language = Get.find<LanguageController>();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(() {
          // if (!theme.isLoaded.value || !language.isLoaded.value) {
          //   return MaterialApp(home: SplashCinematicFull());
          // } else
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'تطبيق إيجار',
            theme: AppTheme.lightTheme, // ثيم Light
            darkTheme: AppTheme.darkTheme, // ثيم Dark
            themeMode: theme.themeMode, // يختار الوضع حسب controller
            locale: Get.locale ?? Locale('en'), // اللغة الافتراضية
            fallbackLocale: Locale('en'),
            translations: Translate(), // الترجمات
            builder: (context, child) {
              return Directionality(
                textDirection: Get.locale?.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child!,
              );
            },
            home: LoginScreen(),
            getPages: routes,
          );
        });
      },
    );
  }
}

class SplashCinematicFull extends StatefulWidget {
  @override
  State<SplashCinematicFull> createState() => _SplashCinematicFullState();
}

class _SplashCinematicFullState extends State<SplashCinematicFull>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _logoController;
  late AnimationController _loaderController;
  late AnimationController _typingController;

  final int particleCount = 30;
  final List<Offset> particles = [];

  // Parallax offsets
  double _tiltX = 0;
  double _tiltY = 0;

  String subtitle = "Find your perfect home";
  String displayedText = "";

  @override
  void initState() {
    super.initState();

    // Random particles
    for (int i = 0; i < particleCount; i++) {
      particles.add(Offset(Random().nextDouble(), Random().nextDouble()));
    }

    // Background Animation
    _bgController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat(reverse: true);

    // Logo Animation: Bounce + Glow + 3D
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    // Loader Animation
    _loaderController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat();

    // Typing Animation
    _typingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: subtitle.length * 100),
    );

    _typingController.addListener(() {
      int count = (_typingController.value * subtitle.length).round();
      if (count > subtitle.length) count = subtitle.length;
      setState(() {
        displayedText = subtitle.substring(0, count);
      });
    });
    _typingController.forward();

    // Navigate after 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      Get.offAllNamed("/home");
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _logoController.dispose();
    _loaderController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  // Parallax tilt simulation
  void _updateTilt(DragUpdateDetails details, Size size) {
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;
    setState(() {
      _tiltX = (dx - size.width / 2) / (size.width / 2) * 0.15;
      _tiltY = (dy - size.height / 2) / (size.height / 2) * -0.15;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onPanUpdate: (details) => _updateTilt(details, size),
      child: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          final t = _bgController.value;

          // Dynamic Gradient Background
          final color1 = Color.lerp(
            Colors.deepPurple,
            Colors.blueAccent,
            sin(t * pi),
          )!;
          final color2 = Color.lerp(
            Colors.pinkAccent,
            Colors.indigoAccent,
            cos(t * pi),
          )!;

          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Floating Particles
                  ...particles.map((p) {
                    final dx = p.dx * size.width + 25 * sin(t * 2 * pi);
                    final dy = p.dy * size.height + 25 * cos(t * 2 * pi);
                    return Positioned(
                      left: dx,
                      top: dy,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }).toList(),

                  // Center Content
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo 3D + Glow + Bounce
                        AnimatedBuilder(
                          animation: _logoController,
                          builder: (context, child) {
                            final scale = 0.9 + 0.15 * _logoController.value;
                            final glow = 12 + 18 * _logoController.value;

                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..rotateX(_tiltY)
                                ..rotateY(_tiltX)
                                ..scale(scale),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.7),
                                      blurRadius: glow,
                                      spreadRadius: glow / 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.apartment,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 30),

                        // App Name
                        Text(
                          "Dream House",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Animated Typing Subtitle
                        Text(
                          displayedText,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),

                        SizedBox(height: 50),

                        // Loader Dots
                        AnimatedBuilder(
                          animation: _loaderController,
                          builder: (context, child) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(3, (i) {
                                double anim =
                                    (_loaderController.value + i * 0.3) % 1;
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(
                                      0.3 + 0.7 * anim,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
