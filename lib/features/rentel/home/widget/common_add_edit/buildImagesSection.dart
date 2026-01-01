import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildImageThumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
          padding: EdgeInsets.symmetric(vertical: 4.h),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5.w),
            border: Border.all(
              color: theme.primaryColor.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 30.sp,
                color: theme.primaryColor,
              ),
              SizedBox(height: 1.h),
              Text(
                "add_images_btn".tr,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                "image_format_info".tr,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 3.h),
      Obx(() {
        final List<dynamic> allImages = isEditMode
            ? [...controller.existingImages, ...controller.selectedImages]
            : controller.selectedImages;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: allImages.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Text(
                      "no_images_selected".tr,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 3.w,
                    runSpacing: 1.5.h,
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
