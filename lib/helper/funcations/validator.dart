import 'package:get/get.dart';

String? myValidator(String? val, min, max, type) {
  if (val!.isEmpty) {
    return "15".tr;
  }

  if (type == "email") {
    if (!val.endsWith("@gmail.com")) {
      return "Example 123@gmail.com";
    }
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "16".tr;
    }
  }
  if (type == "phone") {
    if (val.length < 10) {
      return "17".tr;
    }
  }
  if (type == "password") {
    if (val.length < min) {
      return "${"18".tr} $min";
    }

    if (val.length > max) {
      return "${"19".tr}$max";
    }
  }
  return null;
}
