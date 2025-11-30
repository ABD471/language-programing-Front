import 'package:apartment_rental_system/features/auth/screen/register.dart';
import 'package:apartment_rental_system/features/mainwrapper/screen/mainwrapper.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';

// ------------------- شاشة تسجيل الدخول -------------------
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.apartment_rounded,
                size: 80,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 20),
              const Text(
                'أهلاً بك في إيجار',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const Text(
                'استأجر منزلك المثالي بسهولة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppTheme.textLight),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'رقم الموبايل',
                  prefixIcon: Icon(Icons.phone_android),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // محاكاة تسجيل الدخول
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainWrapper()),
                  );
                },
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ليس لديك حساب؟'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text('إنشاء حساب جديد'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// ------------------- الشاشة الرئيسية (بحث وتصفح) -------------------




// ------------------- شاشة التفاصيل -------------------




