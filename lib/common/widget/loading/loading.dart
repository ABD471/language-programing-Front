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
          mainAxisSize: MainAxisSize.min, 
          children: [
           
            SizedBox(
              height: 30.h, 
              width: 40.w,
              child: Lottie.asset(
                'assets/lottie/HomeIconLoading.json',
                fit: BoxFit.contain,
              ),
            ),

            
            SizedBox(height: 0),

           
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
