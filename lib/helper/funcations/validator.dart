import 'package:get/get.dart';

String? myValidator(String? val, min, max, type) {
  if (val!.isEmpty) {
    return "empty".tr;
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
      return "format".tr;
    }
  }
  if (type == "password") {
    if (val.length < min) {
      return "${"passwordmin".tr} $min";
    }

    if (val.length > max) {
      return "${"passwordmax".tr}$max";
    }
  }
  return null;
}
