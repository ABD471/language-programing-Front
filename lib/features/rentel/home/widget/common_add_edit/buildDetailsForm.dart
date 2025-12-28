import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          const SizedBox(width: 12),

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
      const SizedBox(height: 8),

      CustomTextField(
        label: "area".tr,
        controller: controller.areaController,
        keyboardType: TextInputType.number,
        icon: Icons.square_foot_rounded,
      ),

      CustomTextField(
        label: "price".tr,
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        icon: Icons.payments_outlined,
      ),
    ],
  );
}
