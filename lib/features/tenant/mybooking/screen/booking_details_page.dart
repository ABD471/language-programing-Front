import 'package:apartment_rental_system/features/tenant/mybooking/controller/bookingDetailsController.dart';
import 'package:apartment_rental_system/features/tenant/mybooking/widget/bookingSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookingDetailsController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 30.h, // Resize: Height based on screen
              pinned: true,
              iconTheme: IconThemeData(
                color: isDark ? Colors.white : Colors.black,
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  controller.apartment.title.tr, // Translation
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 14.sp, // Resize
                  ),
                ),
                // خلفية الصورة (مثال)
                background: Image.network(
                  controller.apartment.imageUrl.isNotEmpty
                      ? controller.apartment.imageUrl
                      : '',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(4.w), // Resize
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// حالة الحجز
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.8.h,
                      ),
                      decoration: BoxDecoration(
                        color: controller.statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.booking.value.status.name.tr, // Translation
                        style: TextStyle(
                          color: controller.statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp, // Resize
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    _card(
                      context,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _iconInfo(
                            context,
                            Icons.calendar_today,
                            'from_date'.tr, // Translation
                            controller.startDate.toString().split(' ')[0],
                          ),
                          _iconInfo(
                            context,
                            Icons.calendar_month,
                            'to_date'.tr, // Translation
                            controller.endDate.toString().split(' ')[0],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),

                    /// تفاصيل الشقة
                    Text(
                      'apartment_details'.tr, // Translation
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp, // Resize
                      ),
                    ),

                    SizedBox(height: 1.h),

                    _card(
                      context,
                      child: Column(
                        children: [
                          _infoRow(
                            context,
                            Icons.attach_money,
                            'price'.tr, // Translation
                            '${controller.apartment.price} ${'currency'.tr}',
                          ),
                          _infoRow(
                            context,
                            Icons.bed,
                            'bedrooms'.tr, // Translation
                            controller.apartment.bedrooms.toString(),
                          ),
                          _infoRow(
                            context,
                            Icons.bathtub,
                            'bathrooms'.tr, // Translation
                            controller.apartment.bathrooms.toString(),
                          ),
                          _infoRow(
                            context,
                            Icons.square_foot,
                            'area'.tr, // Translation
                            '${controller.apartment.area} ${'sqm'.tr}',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // /// الأزرار التفاعلية
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Obx(
                    //         () => OutlinedButton(
                    //           onPressed: controller.isLoading.value
                    //               ? null
                    //               : () async =>
                    //                     await controller.cancelBooking(),
                    //           style: OutlinedButton.styleFrom(
                    //             foregroundColor: Colors.red,
                    //             side: const BorderSide(color: Colors.red),
                    //             padding: EdgeInsets.all(1.8.h), // Resize
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(14),
                    //             ),
                    //           ),
                    //           child: controller.isLoading.value
                    //               ? SizedBox(
                    //                   width: 5.w,
                    //                   height: 5.w,
                    //                   child: const CircularProgressIndicator(
                    //                     strokeWidth: 2,
                    //                     color: Colors.red,
                    //                   ),
                    //                 )
                    //               : Text(
                    //                   'cancel_booking'.tr,
                    //                   style: TextStyle(fontSize: 12.sp),
                    //                 ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 3.w),
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           Get.bottomSheet(
                    //             BookingEditSheet(controller: controller),
                    //             isScrollControlled: true,
                    //             backgroundColor: Theme.of(context).cardColor,
                    //           );
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //           padding: EdgeInsets.all(1.8.h), // Resize
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(14),
                    //           ),
                    //         ),
                    //         child: Text(
                    //           'edit_booking'.tr,
                    //           style: TextStyle(fontSize: 12.sp),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(4.w), // Resize
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 0.5.h), // Resize
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h), // Resize
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 2.5.h,
          ), // Resize icon
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 11.sp,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  Widget _iconInfo(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 3.h,
        ), // Resize icon
        SizedBox(height: 0.8.h),
        Text(
          title,
          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 10.sp),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
        ),
      ],
    );
  }
}
