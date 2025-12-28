import 'package:apartment_rental_system/features/tenant/mybooking/controller/bookingDetailsController.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/widget/bookingSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookingDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(controller.apartment.title),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// حالة الحجز
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: controller.statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.booking.value.status.name,
                        style: TextStyle(
                          color: controller.statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// التواريخ
                    _card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _iconInfo(
                            Icons.calendar_today,
                            'من',
                            controller.startDate.toString().split(' ')[0],
                          ),
                          _iconInfo(
                            Icons.calendar_month,
                            'إلى',
                            controller.endDate.toString().split(' ')[0],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// تفاصيل الشقة
                    Text(
                      'تفاصيل الشقة',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    _card(
                      child: Column(
                        children: [
                          _infoRow(
                            Icons.attach_money,
                            'السعر',
                            controller.apartment.price,
                          ),
                          _infoRow(
                            Icons.bed,
                            'غرف النوم',
                            controller.apartment.bedrooms.toString(),
                          ),
                          _infoRow(
                            Icons.bathtub,
                            'الحمامات',
                            controller.apartment.bathrooms.toString(),
                          ),
                          _infoRow(
                            Icons.square_foot,
                            'المساحة',
                            '${controller.apartment.area} م²',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => OutlinedButton(
                              onPressed: controller.isLoading.value
                                  ? null // تعطيل الزر أثناء التحميل
                                  : () async {
                                      await controller.cancelBooking();
                                    },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.all(14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.red,
                                      ),
                                    )
                                  : const Text('إلغاء الحجز'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.bottomSheet(
                                BookingEditSheet(controller: controller),
                                isScrollControlled: true,
                              );
                            },
                            child: const Text('تعديل الحجز'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _iconInfo(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 6),
        Text(title),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
