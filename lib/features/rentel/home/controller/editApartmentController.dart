import 'dart:io';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/rentel/home/controller/rental_home_controller.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class EditApartmentController extends GetxController {
  late ApartmentTest apartment;

  var currentStep = 0.obs;
  var isUpdating = false.obs;

  var pickedLocation = LatLng(33.5138, 36.2765).obs;
  var latitude = "33.5138".obs;
  var longitude = "36.2765".obs;
  var selectedCity = "Damascus".obs;

  final List<String> cities = [
    "Damascus",
    "Aleppo",
    "Homs",
    "Hama",
    "Latakia",
    "Tartus",
  ];

  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController priceController;
  late TextEditingController roomsController;
  late TextEditingController bathroomsController;
  late TextEditingController areaController;

  var existingImages = <String>[].obs;
  var selectedImages = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    apartment = Get.arguments;

    titleController = TextEditingController(text: apartment.title);
    descController = TextEditingController(text: apartment.description);
    priceController = TextEditingController(text: apartment.price);
    roomsController = TextEditingController(
      text: apartment.bedrooms.toString(),
    );
    bathroomsController = TextEditingController(
      text: apartment.bathrooms.toString(),
    );
    areaController = TextEditingController(text: apartment.area.toString());

    try {
      double lat = double.parse(apartment.address.latitude);
      double lng = double.parse(apartment.address.longitude);
      pickedLocation.value = LatLng(lat, lng);
      latitude.value = apartment.address.latitude;
      longitude.value = apartment.address.longitude;
      selectedCity.value = apartment.address.city;
    } catch (e) {
      debugPrint("Error parsing coordinates in Edit Controller: $e");
    }

    existingImages.value = apartment.images.map((e) => e.url).toList();
  }

  void updateLocation(LatLng position) {
    pickedLocation.value = position;
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
  }

  void pickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      selectedImages.addAll(images.map((img) => File(img.path)));
    }
  }

  void removeImage(int index, bool isNetwork) {
    if (isNetwork) {
      existingImages.removeAt(index);
    } else {
      selectedImages.removeAt(index - existingImages.length);
    }
  }

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    } else {
      updateApartment();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<void> updateApartment() async {
    try {
      isUpdating(true);

      Map<String, String> fields = {
        "_method": "PUT",
        "title": titleController.text,
        "description": descController.text,
        "price": priceController.text,
        "bedrooms": roomsController.text,
        "bathrooms": bathroomsController.text,
        "payment_information": "Cash",
        "area": areaController.text,
        "longitude": longitude.value,
        "latitude": latitude.value,
        "city": selectedCity.value,
      };

      Map<String, File> files = {};
      for (int i = 0; i < selectedImages.length; i++) {
        files["images[$i]"] = selectedImages[i];
      }

      final response = await ApiService.postMultipartRequest(
        url: "${(urlClient["edit"]!)}${apartment.id}",
        fields: fields,
        files: files,
        useAuth: true,
      );

      if (response['statusCode'] == 200) {
        if (Get.isRegistered<RentalApartmentController>()) {
          Get.find<RentalApartmentController>().fetchMyApartments();
        }
        Get.back();
        _showStyledSnackbar(
          title: "success_title".tr,
          message: "update_success_msg".tr,
          isError: false,
        );
      } else {
        _showStyledSnackbar(
          title: "error_title".tr,
          message: "update_failed_msg".tr,
          isError: true,
        );
      }
    } catch (e) {
      _showStyledSnackbar(
        title: "connection_error".tr,
        message: e.toString(),
        isError: true,
      );
    } finally {
      isUpdating(false);
    }
  }

  void _showStyledSnackbar({
    required String title,
    required String message,
    required bool isError,
  }) {
    final context = Get.context!;
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDark
          ? (isError
                ? Colors.redAccent.withOpacity(0.8)
                : theme.colorScheme.surface.withOpacity(0.9))
          : (isError ? Colors.red : theme.primaryColor),
      colorText: Colors.white,
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
        size: 28,
      ),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    priceController.dispose();
    roomsController.dispose();
    bathroomsController.dispose();
    areaController.dispose();
    super.onClose();
  }
}
