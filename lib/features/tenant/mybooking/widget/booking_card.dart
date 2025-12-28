import 'package:apartment_rental_system/features/tenant/mybooking/controller/myBookingController.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/model/bookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/maintheme.dart';
import 'status_badge.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;
  final controller = Get.find<BookingsController>();
  BookingCard({super.key, required this.booking});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool _isHovered = false;
  bool _isCancelling = false;
  @override
  Widget build(BuildContext context) {
    final Apartment apartment = widget.booking.apartment;

    // تنسيق التاريخ بشكل جميل: السبت، 21 ديسمبر
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppTheme.primary.withOpacity(0.25)
                    : Colors.black.withOpacity(0.06),
                blurRadius: _isHovered ? 35 : 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primary.withOpacity(0.5)
                  : Colors.grey.shade100,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              // --- القسم الأول: الصورة والسعر والحالة ---
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      // image: DecorationImage(
                      //   image: NetworkImage(apartment.images.first.url),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  // تأثير الظل السفلي على الصورة لجعل النص يبرز
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // عرض السعر فوق الصورة بتصميم زجاجي
                  Positioned(
                    bottom: 25,
                    left: 25,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: Text(
                        '\$${apartment.price}',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // شارة الحالة في الأعلى
                  Positioned(
                    top: 25,
                    right: 25,
                    child: StatusBadge(status: widget.booking.status),
                  ),
                ],
              ),

              // --- القسم الثاني: معلومات الشقة ---
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apartment.title ?? "شقة سكنية مميزة",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF232323),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // _buildInfoTile(Icons.location_on_rounded, apartment.address ?? "غير محدد", Colors.redAccent),
                        const SizedBox(width: 15),
                        _buildInfoTile(
                          Icons.calendar_month_rounded,
                          formattedDate,
                          Colors.blueAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // --- القسم الثالث: الأزرار المطورة ---
                    Row(
                      children: [
                        // زر عرض التفاصيل (الأساسي)
                        Expanded(
                          flex: 2,
                          child: _buildActionButton(
                            label: 'عرض التفاصيل',
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

                        // أزرار الحالات (إلغاء أو تقييم)
                        if (widget.booking.status == BookingStatus.pending) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: _buildActionButton(
                              label: 'إلغاء',
                              icon: Icons.close_rounded,
                              isPrimary: true,
                              color: Colors.redAccent,
                              isLoading: _isCancelling, // تمرير الحالة هنا
                              onTap: () async {
                                setState(
                                  () => _isCancelling = true,
                                ); // بدء التحميل
                                try {
                                  await widget.controller.cancelBooking(
                                    widget.booking,
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() => _isCancelling = false);
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                        if (widget.booking.status ==
                            BookingStatus.confirmed) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: _buildActionButton(
                              label: 'تقييم',
                              icon: Icons.star_rounded,
                              isPrimary: false,
                              color: Colors.amber.shade700,
                              onTap: () {
                                // أضف هنا كود التقييم
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

  // بناء أيقونات المعلومات الصغيرة (الموقع، التاريخ)
  Widget _buildInfoTile(IconData icon, String text, Color color) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // بناء الأزرار بتصميم عصري (الأساسي والثانوي)
  // بناء الأزرار بتصميم عصري مع دعم حالة التحميل
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required bool isPrimary,
    required Color color,
    required VoidCallback onTap,
    bool isLoading = false, // بارامتر جديد
  }) {
    return InkWell(
      onTap: isLoading ? null : onTap, // منع الضغط أثناء التحميل
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isLoading
              ? Colors.grey.shade300
              : (isPrimary ? color : color.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(18),
          boxShadow: (isPrimary && !isLoading)
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
          border: isPrimary ? null : Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? Colors.white : color,
                  ),
                ),
              )
            else ...[
              Icon(icon, color: isPrimary ? Colors.white : color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
