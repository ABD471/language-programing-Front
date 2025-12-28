 import 'package:apartment_rental_system/features/rentel/home/controller/rental_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDeleteDialog(BuildContext context, int id) {
  final controller  = Get.find<RentalApartmentController>();
    final theme = Theme.of(context);
    Get.defaultDialog(
      title: "confirm_delete_title".tr,
      middleText: "confirm_delete_msg".tr,
      titleStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: theme.colorScheme.surface,
      radius: 30,
      contentPadding: const EdgeInsets.all(25),
      textConfirm: "yes".tr,
      textCancel: "cancel".tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      onConfirm: () {
        controller.deleteApartment(id);
        Get.back();
      },
    );
  }