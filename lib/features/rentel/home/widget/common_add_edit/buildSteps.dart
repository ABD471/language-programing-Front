import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildDetailsForm.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildImagesSection.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildBasicsForm.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/createStep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

List<Step> buildSteps(BuildContext context, dynamic controller) {
  final theme = Theme.of(context);

  return [
    createStep(
      index: 0,
      title: "basics".tr,
      content: buildBasicsForm(controller),
      isActive: controller.currentStep.value >= 0,
      controller: controller,
    ),
    Step(
      isActive: controller.currentStep.value >= 1,
      state: controller.currentStep.value > 1
          ? StepState.complete
          : StepState.indexed,
      title: Text("details".tr),
      content: Column(
        children: [
          buildDetailsForm(controller),
          SizedBox(height: 2.h),
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedCity.value,
              dropdownColor: theme.colorScheme.surface,
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 12.sp,
              ),
              items: controller.cities
                  .map<DropdownMenuItem<String>>(
                    (String city) => DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    ),
                  )
                  .toList(),
              onChanged: (val) => controller.selectedCity.value = val!,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.surface,
                labelText: "select_city".tr,
                labelStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 11.sp,
                ),
                prefixIcon: Icon(
                  Icons.location_city_rounded,
                  color: theme.primaryColor,
                  size: 18.sp,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.w),
                  borderSide: BorderSide(
                    color: theme.primaryColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.w),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "tap_on_map_hint".tr,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 9.sp),
          ),
          SizedBox(height: 1.h),
          Container(
            height: 35.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              border: Border.all(color: theme.primaryColor.withOpacity(0.5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.w),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: controller.pickedLocation.value,
                  initialZoom: 13.0,
                  onTap: (tapPosition, point) =>
                      controller.updateLocation(point),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.apartment_rental_system.app',
                  ),
                  Obx(
                    () => MarkerLayer(
                      markers: [
                        Marker(
                          point: controller.pickedLocation.value,
                          width: 12.w,
                          height: 12.w,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    createStep(
      controller: controller,
      index: 2,
      title: "images".tr,
      content: buildImagesSection(context, controller),
      isActive: controller.currentStep.value >= 2,
      state: controller.currentStep.value == 2
          ? StepState.editing
          : (controller.currentStep.value > 2
                ? StepState.complete
                : StepState.indexed),
    ),
  ];
}
