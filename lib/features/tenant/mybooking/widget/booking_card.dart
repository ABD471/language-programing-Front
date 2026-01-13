import 'package:apartment_rental_system/features/tenant/mybooking/controller/myBookingController.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../theme/maintheme.dart';
import 'status_badge.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;
  final BookingsController controller = Get.find<BookingsController>();
  BookingCard({super.key, required this.booking});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool _isHovered = false;
  bool _isCancelling = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Apartment apartment = widget.booking.apartment;

    final String formattedDate = DateFormat(
      'EEE, d MMM yyyy', // أضفنا السنة لمزيد من الوضوح
    ).format(widget.booking.startDate);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.01 : 1.0, // تقليل التكبير ليناسب العرض الكامل
        duration: const Duration(milliseconds: 300),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          // تقليل الهوامش الجانبية ليأخذ كامل العرض
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: isDark ? Theme.of(context).cardColor : Colors.white,
            borderRadius: BorderRadius.circular(
              20,
            ), // زوايا أقل حدة للكرت العريض
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black87 : Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  // الصورة عريضة جداً
                  Container(
                    height: 25.h, // زيادة الارتفاع ليتناسب مع العرض
                    width: double.infinity,
                    margin: EdgeInsets.all(2.w), // هامش داخلي صغير للصورة
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        apartment.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.broken_image, size: 40.sp),
                        ),
                      ),
                    ),
                  ),
                  // السعر بشكل بارز
                  Positioned(
                    bottom: 4.h,
                    left: 5.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 8),
                        ],
                      ),
                      child: Text(
                        '${apartment.price} ${'currency'.tr}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp, // خط السعر كبير
                        ),
                      ),
                    ),
                  ),
                  // حالة الحجز
                  Positioned(
                    top: 4.h,
                    right: 5.w,
                    child: Transform.scale(
                      scale: 1.2, // تكبير علامة الحالة
                      child: StatusBadge(status: widget.booking.status),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apartment.title.tr,
                      style: TextStyle(
                        fontSize: 18.sp, // عنوان كبير جداً
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    // معلومات التاريخ بأيقونة كبيرة
                    _buildInfoSection(
                      context,
                      Icons.calendar_month_rounded,
                      formattedDate,
                      Colors.blueAccent,
                    ),

                    SizedBox(height: 2.5.h),

                    // أزرار التحكم عريضة وواضحة
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildActionButton(
                            context,
                            label: 'view_details'.tr,
                            icon: Icons.explore_rounded,
                            isPrimary: true,
                            color: AppTheme.primary,
                            onTap: () {
                              Get.toNamed(
                                '/bookingDetailsScreen',
                                arguments: widget.booking,
                              );
                            },
                          ),
                        ),
                        if (widget.booking.status == BookingStatus.pending) ...[
                          SizedBox(width: 3.w),
                          Expanded(
                            flex: 1,
                            child: _buildActionButton(
                              context,
                              label: 'cancel'.tr,
                              icon: Icons.close_rounded,
                              isPrimary: false,
                              color: Colors.redAccent,
                              isLoading: _isCancelling,
                              onTap: () async {
                                setState(() => _isCancelling = true);
                                try {
                                  await widget.controller.cancelBooking(
                                    widget.booking,
                                  );
                                } finally {
                                  if (mounted)
                                    setState(() => _isCancelling = false);
                                }
                              },
                            ),
                          ),
                        ],
                        if (widget.booking.status ==
                            BookingStatus.confirmed) ...[
                          SizedBox(width: 3.w),
                          Expanded(
                            flex: 1,
                            child: _buildActionButton(
                              context,
                              label: 'rate'.tr,
                              icon: Icons.star_rounded,
                              isPrimary: false,
                              color: Colors.amber.shade800,
                              onTap: () {
                                widget.controller.openRatingDialog(
                                  widget.booking,
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت لعرض المعلومات بخط عريض
  Widget _buildInfoSection(
    BuildContext context,
    IconData icon,
    String text,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(icon, size: 22.sp, color: color), // أيقونة كبيرة
        SizedBox(width: 3.w),
        Text(
          text,
          style: TextStyle(
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
            fontSize: 16.sp, // خط المعلومات كبير
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isPrimary,
    required Color color,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          vertical: 1.8.h,
        ), // زيادة الارتفاع للأزرار
        decoration: BoxDecoration(
          color: isLoading
              ? (isDark ? Colors.grey.shade800 : Colors.grey.shade300)
              : (isPrimary ? color : color.withOpacity(isDark ? 0.15 : 0.1)),
          borderRadius: BorderRadius.circular(15),
          border: isPrimary
              ? null
              : Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? Colors.white : color,
                  ),
                ),
              )
            else ...[
              Icon(icon, color: isPrimary ? Colors.white : color, size: 18.sp),
              SizedBox(width: 2.w),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp, // خط الأزرار واضح
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
