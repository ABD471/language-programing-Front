import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controller/myBookingController.dart';
import '../model/bookingModel.dart';
import 'booking_card.dart';

class BookingList extends StatelessWidget {
  final BookingStatus status;
  const BookingList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookingsController>();

    return Obx(() {
      // 1. حالة التحميل
      if (controller.isLoading.value && controller.bookings.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // 2. حالة وجود خطأ
      if (controller.errorMessage.isNotEmpty && controller.bookings.isEmpty) {
        return _buildScrollableEmptyState(
          controller,
          icon: Icons.error_outline,
          message: controller.errorMessage.value,
        );
      }

      final bookings = controller.getBookingsByStatus(status);

      // 3. حالة عدم وجود حجوزات لهذه التبويب
      if (bookings.isEmpty) {
        return _buildScrollableEmptyState(
          controller,
          icon: Icons.event_busy_rounded,
          message: 'لا توجد حجوزات لهذه الحالة حالياً',
        );
      }

      // 4. عرض القائمة مع الأنيميشن والسحب للتحديث
      return RefreshIndicator(
        onRefresh: controller.fetchBookings,
        displacement: 40, // إزاحة مؤشر التحميل ليكون أوضح
        edgeOffset: 20,
        child: AnimationLimiter(
          child: ListView.builder(
            // الحفاظ على حالة القائمة وجعلها قابلة للسحب دائماً
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(), // تأثير الارتداد الجمالي
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  curve: Curves.easeOutCubic,
                  child: FadeInAnimation(
                    child: BookingCard(booking: bookings[index]),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  // دالة لبناء واجهة "لا يوجد بيانات" قابلة للسحب (Refreshable)
  Widget _buildScrollableEmptyState(
    BookingsController controller, {
    required IconData icon,
    required String message,
  }) {
    return RefreshIndicator(
      onRefresh: controller.fetchBookings,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          SizedBox(height: Get.height * 0.25), // موازنة العناصر في المنتصف
          Center(
            child: Column(
              children: [
                // خلفية دائرية خفيفة للأيقونة لزيادة الجمالية
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 70, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'اسحب للأسفل للتحديث',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
          // سبيسر لضمان أن القائمة أطول من الشاشة ليتم التمرير
          SizedBox(height: Get.height * 0.2),
        ],
      ),
    );
  }
}
