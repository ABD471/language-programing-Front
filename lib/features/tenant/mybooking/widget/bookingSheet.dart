import 'package:apartment_rental_system/features/tenant/mybooking/controller/bookingDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingEditSheet extends StatelessWidget {
  final BookingDetailsController controller;

  const BookingEditSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'تعديل تاريخ الحجز',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('تاريخ البداية'),
                subtitle: Text(controller.startDate.toString().split(' ')[0]),
                onTap: () => controller.pickDate(context, true),
              ),

              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('تاريخ النهاية'),
                subtitle: Text(controller.endDate.toString().split(' ')[0]),
                onTap: () => controller.pickDate(context, false),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.updateBooking,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('حفظ التعديل'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
