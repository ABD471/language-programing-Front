import 'dart:io';
import 'dart:typed_data';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/common/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileController extends GetxController {
  Future pickImage(bool isProfile);
  Future pickDate();
  void saveProfile();
  Future<void> loadProfile();
}

class ProfileControllerImpl extends ProfileController {
  Profile profileData = Profile(
    firstName: "",
    lastName: "",
    dateOfBirth: DateTime.now(),
  );

  // الكنترولرز مهيأة فورًا
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController dobController = TextEditingController();

  RxBool isLoading = true.obs;
  RxBool hasChanges = false.obs;

  Rx<File?> profileImageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadAndFill(); // تحميل البيانات وملء الكنترولرز
  }

  Future<void> _loadAndFill() async {
    await loadProfile();
    await loadFilePicture();

    // تعبئة الكنترولرز بعد جلب البيانات
    firstNameController.text = profileData.firstName;
    lastNameController.text = profileData.lastName;
    dobController.text = profileData.dateOfBirth.toIso8601String().split(
      "T",
    )[0];

    isLoading.value = false;

    // مراقبة التعديلات
    firstNameController.addListener(() {
      if (firstNameController.text != profileData.firstName) {
        hasChanges.value = true;
      }
    });

    lastNameController.addListener(() {
      if (lastNameController.text != profileData.lastName) {
        hasChanges.value = true;
      }
    });
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    super.onClose();
  }

  @override
  Future pickDate() async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: profileData.dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      final formatted = date.toIso8601String().split("T")[0];

      if (formatted != dobController.text) {
        hasChanges.value = true;
      }

      dobController.text = formatted;
    }
  }

  @override
  Future pickImage(bool isProfile) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      hasChanges.value = true;

      if (isProfile) {
        profileImageFile.value = File(picked.path);
      }
    }
  }

  Future<void> updateProfile() async {
    if (!hasChanges.value) {
      Get.snackbar(
        "Warning".tr,
        "no_changes_to_save".tr,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      Map<String, String> fields = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "date_of_birth": dobController.text,
      };

      Map<String, File> files = {};
      if (profileImageFile.value != null) {
        files["profile_picture"] = profileImageFile.value!;
      }

      final response = await ApiService.postMultipartRequest(
        url: urlClient["updateProfile"]!,
        useAuth: true,
        fields: fields,
        files: files,
      );

      isLoading.value = false;

      final statusCode = response["statusCode"];
      final body = response["body"];

      // ================================
      //    200 + status = 1  (SUCCESS)
      // ================================
      if (statusCode == 200 && body["status"] == 1) {
        Get.snackbar(
          "Success".tr,
          body["message"] ?? "Profile updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        // تحديث البيانات المحلية
        profileData.firstName = firstNameController.text;
        profileData.lastName = lastNameController.text;
        profileData.dateOfBirth = DateTime.parse(dobController.text);

        hasChanges.value = false;
        return;
      }

      // ================================
      //             403
      // ================================
      if (statusCode == 403) {
        Get.snackbar(
          "Unauthorized".tr,
          body["message"] ?? "Unauthorized access",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // ================================
      //             404
      // ================================
      if (statusCode == 404) {
        Get.snackbar(
          "Not Found".tr,
          body["message"] ?? "Profile not found",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // ================================
      //     أي خطأ آخر
      // ================================
      Get.snackbar(
        "Error".tr,
        body["message"] ?? "Unexpected error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void saveProfile() {
    updateProfile();
  }

  @override
  Future<void> loadProfile() async {
    try {
      final response = await ApiService.getRequest(
        url: urlClient["getProfile"]!,
        useAuth: true,
      );

      final statusCode = response["statusCode"];
      final body = response["body"];

      // ==========================
      // الحالة الناجحة 200
      // ==========================
      if (statusCode == 200 && body["status"] == 1) {
        profileData = Profile.fromJson(body["data"]["profile"]);
        print("Profile loaded successfully");
        return;
      }

      // ==========================
      // الحالة 404 (عدم وجود بروفايل)
      // ==========================
      if (statusCode == 404) {
        Get.snackbar(
          "Not Found",
          body["message"] ?? "Profile not found",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // ==========================
      // الحالة 403 (غير مخول)
      // ==========================
      if (statusCode == 403) {
        Get.snackbar(
          "Unauthorized",
          body["message"] ?? "Unauthorized access",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // ==========================
      // أي حالة أخرى
      // ==========================
      Get.snackbar(
        "Error",
        "Unexpected error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        "error ",
        "Unexpected",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> loadFilePicture() async {
    Uint8List? bytes = await ApiService.downloadImage(
      payload: {"type": "profile_picture"},
      url: urlClient["getpictureProfile"]!,
      
    );

    if (bytes != null) {
      profileData.profileImageBytes = bytes;
      update();
    } else {
      Get.snackbar(
        "Exception",
        toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
