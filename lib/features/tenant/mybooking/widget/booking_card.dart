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
    print(apartment.imageUrl);
    final String formattedDate = DateFormat(
      'EEE, d MMM',
    ).format(widget.booking.startDate);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
          decoration: BoxDecoration(
            color: isDark ? Theme.of(context).cardColor : Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppTheme.primary.withOpacity(isDark ? 0.15 : 0.25)
                    : (isDark
                          ? Colors.black45
                          : Colors.black.withOpacity(0.06)),
                blurRadius: _isHovered ? 35 : 20,
                offset: Offset(0, 1.h),
              ),
            ],
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primary.withOpacity(0.5)
                  : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 22.h,
                    width: double.infinity,
                    margin: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isDark ? Colors.grey[850] : Colors.grey[200],
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(isDark ? 0.6 : 0.4),
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          apartment.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    left: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey[900]!.withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
                        ],
                      ),
                      child: Text(
                        '${apartment.price} ${'currency'.tr}',
                        style: TextStyle(
                          color: isDark ? Colors.white : AppTheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    right: 6.w,
                    child: StatusBadge(status: widget.booking.status),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apartment.title.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF232323),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        _buildInfoTile(
                          context,
                          Icons.calendar_month_rounded,
                          formattedDate,
                          Colors.blueAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
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
                              color: Colors.amber.shade700,
                              onTap: () {},
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

  Widget _buildInfoTile(
    BuildContext context,
    IconData icon,
    String text,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(1.2.w),
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 17.sp, color: color),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
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
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: isLoading
              ? (isDark ? Colors.grey.shade800 : Colors.grey.shade300)
              : (isPrimary ? color : color.withOpacity(isDark ? 0.2 : 0.1)),
          borderRadius: BorderRadius.circular(15),
          boxShadow: (isPrimary && !isLoading)
              ? [
                  BoxShadow(
                    color: color.withOpacity(isDark ? 0.2 : 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
          border: isPrimary
              ? null
              : Border.all(color: color.withOpacity(isDark ? 0.3 : 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 15.sp,
                height: 15.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? Colors.white : color,
                  ),
                ),
              )
            else ...[
              Icon(icon, color: isPrimary ? Colors.white : color, size: 16.sp),
              SizedBox(width: 2.w),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
