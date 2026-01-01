import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget buildBasicsForm(dynamic controller) {
  return Column(
    children: [
      CustomTextField(
        label: "title_label".tr,
        controller: controller.titleController,
      ),
      SizedBox(height: 2.h),
      CustomTextField(
        label: "desc_label".tr,
        controller: controller.descController,
        maxLines: 3,
      ),
    ],
  );
}
