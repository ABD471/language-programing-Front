import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/main.dart';

Widget buildSliverAppBar() {
  return SliverAppBar(
    pinned: true,
    expandedHeight: 28.h, // Resize: Responsive height
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.biggest.height;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final collapsed =
            top <= kToolbarHeight + MediaQuery.of(context).padding.top + 1.h;
        final double opacity =
            ((top - kToolbarHeight) / (28.h - kToolbarHeight)).clamp(0.0, 1.0);

        return FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.expand,
            children: [
              _buildBackgroundImage(collapsed),
              _buildBlurOverlay(isDark),
              Positioned(
                top: MediaQuery.of(context).padding.top + 1.h,
                left: 4.w,
                child: _buildNotificationButton(),
              ),
              Positioned(
                left: 5.w,
                right: 5.w,
                bottom: 2.h,
                child: Opacity(
                  opacity: opacity,
                  child: _buildHeaderContent(context),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildBackgroundImage(bool collapsed) {
  return Positioned.fill(
    child: Image.asset(
      'assets/images/logo.jpg',
      fit: BoxFit.cover,
      alignment: Alignment(0, collapsed ? -0.3 : 0),
    ),
  );
}

Widget _buildBlurOverlay(bool isDark) {
  return Positioned.fill(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(isDark ? 0.7 : 0.4),
              Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeaderContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'welcome_user'.trParams({'name': 'أحمد'}),
        style: TextStyle(
          color: Colors.white.withOpacity(0.85),
          fontSize: 11.sp, 
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 0.5.h),
      Text(
        'search_next_apartment'.tr, 
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp, 
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
      SizedBox(height: 1.5.h),
      _buildLocationTag(),
    ],
  );
}

Widget _buildNotificationButton() {
  return ClipOval(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 5.h, // Resize
        width: 5.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 2.8.h,
              ),
              onPressed: () => Get.toNamed('/notificationScreen'),
            ),
            Positioned(
              right: 1.2.h,
              top: 1.2.h,
              child: Container(
                width: 1.h,
                height: 1.h,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildLocationTag() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_on, color: Colors.white, size: 1.8.h),
        SizedBox(width: 2.w),
        Obx(
          () => Text(
            '${'your_location'.tr}: ${locationCtrl.city.value}', 
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
