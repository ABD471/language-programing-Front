import 'package:apartment_rental_system/testuils/contreeelrer.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingButtonTest extends StatelessWidget {
  final ApartmentDetailsControllerTest controller;
  const BookingButtonTest({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final apt = controller.apartment;
    return SafeArea(
      minimum: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => Get.snackbar('مفضلة', 'تم إضافة للمفضلة'),
                icon: const Icon(
                  Icons.star_border_rounded,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showDatePicker(context),

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${apt.price}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        const Text('ل.س'),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.shopping_bag_rounded),
                        SizedBox(width: 8),
                        Text(
                          'احجز الآن',
                          style: TextStyle(fontWeight: FontWeight.w700),
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

  void _showDatePicker(BuildContext context) {
    Get.bottomSheet(
      // SafeArea تضمن عدم التداخل مع شريط التنقل أو النوتش
      SafeArea(
        child: Container(
          // استخدام padding سفلي ديناميكي للحماية من حواف الهاتف
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ), // حواف أنعم
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ليأخذ حجم المحتوى فقط
            children: [
              // مقبض سحب صغير ليعطي إيحاءً للمستخدم بإمكانية الإغلاق (اختياري)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Text(
                'اختر مدة الحجز',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () => _selectDateRange(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                  foregroundColor: AppTheme.primary,
                  elevation: 0,
                ),
                child: const Text('اختيار التاريخ'),
              ),

              const SizedBox(height: 12),

              Obx(() {
                final range = controller.selectedDateRange.value;
                if (range == null) {
                  return const Text(
                    'لم يتم اختيار تاريخ بعد',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'من ${range.start.toString().split(' ')[0]}  إلى  ${range.end.toString().split(' ')[0]}',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isloading.value
                        ? null
                        : () {
                            if (controller.selectedDateRange.value == null) {
                              Get.snackbar('تنبيه', 'يرجى اختيار تاريخ الحجز');
                              return;
                            }
                            controller.booking();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: controller.isloading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'تأكيد الحجز',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // ضروري جداً لتمكين التحكم الكامل في الارتفاع
      backgroundColor:
          Colors.transparent, // لجعل الحواف الدائرية تظهر بشكل صحيح
      elevation: 0,
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      controller.selectedDateRange.value = picked;
    }
  }
}
