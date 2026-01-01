import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../theme/maintheme.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 6.h,
      padding: EdgeInsets.all(0.5.h),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: isDark
            ? Colors.grey.shade500
            : Colors.grey.shade600,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.85)],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.clock, size: 13.sp),
                SizedBox(width: 1.5.w),
                Text('current_tab'.tr, style: TextStyle(fontSize: 10.sp)),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.tick_circle, size: 13.sp),
                SizedBox(width: 1.5.w),
                Text('previous_tab'.tr, style: TextStyle(fontSize: 10.sp)),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.close_circle, size: 13.sp),
                SizedBox(width: 1.5.w),
                Text('cancelled_tab'.tr, style: TextStyle(fontSize: 10.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
