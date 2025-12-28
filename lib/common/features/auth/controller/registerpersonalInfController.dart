import 'dart:io';

import 'package:apartment_rental_system/common/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class RegisterPersonalInfoController extends GetxController {
  Future pickImage(bool isProfile);
  Future pickDate(BuildContext context);
  void savePersonalInfo(BuildContext context);
  void toLogin();
}

class registerPersonalInfoControllerImpl
    extends RegisterPersonalInfoController {
  RxBool isloading = false.obs;
  Rx<File?> profileImageFile = Rx<File?>(null);
  Rx<File?> nationalIdImageFile = Rx<File?>(null);
  late TextEditingController dobController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    dobController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    super.onClose();
  }

  @override
  Future pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      dobController.text = date.toIso8601String().split("T")[0];
    }
  }

  @override
  Future pickImage(bool isProfile) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      if (isProfile) {
        profileImageFile.value = File(picked.path);
      } else {
        nationalIdImageFile.value = File(picked.path);
      }
    }
  }

  @override
  void savePersonalInfo(BuildContext context) async {
    if (profileImageFile.value == null || nationalIdImageFile.value == null) {
      Get.snackbar("error_title".tr, "profile_and_id_required".tr);

      return;
    }

    final profile = {
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "dob": dobController.text,
      "imageProfile": profileImageFile.value,
      "imageNationalid": nationalIdImageFile.value,
    };
    Get.toNamed("/registerAccountScreen", arguments: profile);
  }

  @override
  void toLogin() {
    Get.offAllNamed("/loginScreen");
  }
}
