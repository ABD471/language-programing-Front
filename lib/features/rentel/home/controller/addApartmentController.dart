import 'dart:io';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/rentel/home/controller/rental_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddApartmentController extends GetxController {
  var currentStep = 0.obs;
  var isUploading = false.obs;
  var pickedLocation = LatLng(33.5138, 36.2765).obs;
  var selectedCity = "Damascus".obs;
  var latitude = "33.5138".obs;
  var longitude = "36.2765".obs;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final roomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  final areaController = TextEditingController();
  final List<String> cities = [
    "Damascus",
    "Aleppo",
    "Homs",
    "Hama",
    "Latakia",
    "Deir ez-Zor",
    "Al-Hasakah",
    "Raqqa",
    "Daraa",
    "Idlib",
    "Tartus",
    "As-Suwayda",
  ];
  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    } else {
      submitApartment();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      selectedImages.addAll(images.map((img) => File(img.path)));
    }
  }

  void updateLocation(LatLng position) {
    pickedLocation.value = position;
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
  }

  void removeImage(int index, bool isNetwork) {
    selectedImages.removeAt(index);
  }

  Future<void> submitApartment() async {
    if (titleController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedImages.isEmpty) {
      _showStyledSnackbar(
        title: "warning".tr,
        message: "fill_required".tr,
        isError: true,
      );
      return;
    }

    try {
      isUploading(true);

      Map<String, String> fields = {
        "title": titleController.text,
        "description": descController.text,
        "price": priceController.text,
        "bedrooms": roomsController.text,
        "bathrooms": bathroomsController.text,
        "area": areaController.text,
        "city": selectedCity.value,
        "longitude": longitude.value,
        "latitude": latitude.value,
        "payment_information": "Cash",
      };

      Map<String, File> files = {};
      for (int i = 0; i < selectedImages.length; i++) {
        files["images[$i]"] = selectedImages[i];
      }

      final response = await ApiService.postMultipartRequest(
        url: urlClient["add"]!,
        fields: fields,
        files: files,
        useAuth: true,
      );

      if (response['statusCode'] == 201 || response['statusCode'] == 200) {
        Get.back();
        _showStyledSnackbar(
          title: "success_title".tr,
          message: "success_add".tr,
          isError: false,
        );

        if (Get.isRegistered<RentalApartmentController>()) {
          Get.find<RentalApartmentController>().fetchMyApartments();
        }
      } else {
        _showStyledSnackbar(
          title: "error".tr,
          message: "${"error_msg".tr}: ${response['body']['message'] ?? ''}",
          isError: true,
        );
      }
    } catch (e) {
      _showStyledSnackbar(
        title: "error".tr,
        message: e.toString(),
        isError: true,
      );
    } finally {
      isUploading(false);
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
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.6 : 0.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      overlayBlur: isDark ? 1.2 : 0,
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
