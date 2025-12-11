import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // يجعل الأعمدة تملأ ما يلزم فقط
          children: [
            // اللوتي الأولى
            SizedBox(
              height: 30.h, // اضبط القيم لتناسب شاشتك
              width: 40.w,
              child: Lottie.asset(
                'assets/lottie/HomeIconLoading.json',
                fit: BoxFit.contain,
              ),
            ),

            // لا فراغ: height = 0 يضمن وجودهما مباشرة فوق بعض
            SizedBox(height: 0),

            // اللوتي الثانية
            SizedBox(
              height: 10.h,
              width: 40.w,
              child: Lottie.asset(
                'assets/lottie/Loadingtext.json',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
