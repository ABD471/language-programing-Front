import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildDetailsForm(dynamic controller) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              label: "rooms".tr,
              controller: controller.roomsController,
              keyboardType: TextInputType.number,
              icon: Icons.king_bed_outlined,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: CustomTextField(
              label: "bathrooms".tr,
              controller: controller.bathroomsController,
              keyboardType: TextInputType.number,
              icon: Icons.bathtub_outlined,
            ),
          ),
        ],
      ),
      SizedBox(height: 1.h),
      CustomTextField(
        label: "area".tr,
        controller: controller.areaController,
        keyboardType: TextInputType.number,
        icon: Icons.square_foot_rounded,
      ),
      SizedBox(height: 1.h),
      CustomTextField(
        label: "price".tr,
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        icon: Icons.payments_outlined,
      ),
    ],
  );
}
