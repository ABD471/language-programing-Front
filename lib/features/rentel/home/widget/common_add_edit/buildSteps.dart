import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildDetailsForm.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildImagesSection.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/buildBasicsForm.dart';
import 'package:apartment_rental_system/features/rentel/home/widget/common_add_edit/createStep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

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
          const SizedBox(height: 20),

          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedCity.value,

              dropdownColor: theme.colorScheme.surface,
              style: TextStyle(color: theme.textTheme.bodyLarge?.color),
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
                labelStyle: TextStyle(color: theme.primaryColor),
                prefixIcon: Icon(
                  Icons.location_city_rounded,
                  color: theme.primaryColor,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: theme.primaryColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text("tap_on_map_hint".tr, style: theme.textTheme.bodySmall),
          const SizedBox(height: 10),
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.primaryColor.withOpacity(0.5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
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
