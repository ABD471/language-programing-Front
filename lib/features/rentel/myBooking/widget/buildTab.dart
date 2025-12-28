import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildTab(String label, IconData icon, int count, Color color) {
  return Tab(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 0.4.w, vertical: 0.3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp, color: color),
          SizedBox(width: 1.5.w),
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          if (count > 0) ...[
            SizedBox(width: 1.5.w),
            _buildCountBadge(count, color),
          ],
        ],
      ),
    ),
  );
}

Widget _buildCountBadge(int count, Color color) {
  return Container(
    padding: EdgeInsets.all(3.sp),
    constraints: BoxConstraints(minWidth: 4.w, minHeight: 3.w),
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Center(
      child: Text(
        count.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
