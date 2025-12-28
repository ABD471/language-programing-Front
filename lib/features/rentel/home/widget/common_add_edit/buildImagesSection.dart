import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildImageThumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildImagesSection(BuildContext context, dynamic controller) {
  final theme = Theme.of(context);
  final isEditMode =
      controller.runtimeType.toString() == "EditApartmentController";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: controller.pickImages,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.primaryColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 40,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 10),
              Text(
                "add_images_btn".tr,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "JPG, PNG (Max 5MB)",
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 25),

      Obx(() {
        final List<dynamic> allImages = isEditMode
            ? [...controller.existingImages, ...controller.selectedImages]
            : controller.selectedImages;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: allImages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("no_images_selected".tr),
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    children: allImages.asMap().entries.map((e) {
                      final bool isNetwork =
                          e.value is String && e.value.startsWith('http');
                      return buildImageThumbnail(
                        index: e.key,
                        imageData: e.value,

                        onRemove: () =>
                            controller.removeImage(e.key, isNetwork),
                      );
                    }).toList(),
                  ),
                ),
        );
      }),
    ],
  );
}
