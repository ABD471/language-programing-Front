import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Duration timeout = const Duration(seconds: 40);

class ApiService {
  static Future<Map<String, dynamic>> postRequest({
    required String url,
    Map<String, dynamic>? payload,
    bool useAuth = false,
  }) async {
    try {
      // جلب التوكن إذا لزم الأمر
      String? token;
      if (useAuth) {
        token = "1|pC2jJqNY1vvVNVUuq3nh7CXqFEKtyxCvIhEhdetcb95afab1";
        // token = await storage.read(key: "token");
        if (token == null) throw Exception("token_not_found".tr);
      }

      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              if (useAuth) "Authorization": "Bearer $token",
            },
            body: jsonEncode(payload),
          )
          .timeout(timeout);

      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      // التعامل مع JSON أو نص عادي
      dynamic body;
      try {
        body = jsonDecode(response.body);
      } catch (_) {
        body = response.body;
      }

      return {"statusCode": response.statusCode, "body": body};
    } on SocketException {
      throw Exception("no_internet".tr);
    } on TimeoutException {
      throw Exception("timeout".tr);
    } catch (e) {
      debugPrint("ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  static Future<Map<String, dynamic>> getRequest({
    required String url,

    bool useAuth = false,
  }) async {
    try {
      // جلب التوكن إذا لزم الأمر
      String? token;
      if (useAuth) {
        token = "1|pC2jJqNY1vvVNVUuq3nh7CXqFEKtyxCvIhEhdetcb95afab1";
        // token = await storage.read(key: "token");
        //  if (token == null) throw Exception("token_not_found".tr);
      }

      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              if (useAuth) "Authorization": "Bearer $token",
            },
          )
          .timeout(timeout);

      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      // التعامل مع JSON أو نص عادي
      dynamic body;
      try {
        body = jsonDecode(response.body);
      } catch (_) {
        body = response.body;
      }

      return {"statusCode": response.statusCode, "body": body};
    } on SocketException {
      throw Exception("no_internet".tr);
    } on TimeoutException {
      throw Exception("timeout".tr);
    } catch (e) {
      debugPrint("ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  static Future<Map<String, dynamic>> postMultipartRequest({
    required String url,
    required Map<String, String> fields,
    Map<String, File>? files,
    bool useAuth = false,
  }) async {
    try {
      // جلب التوكن
      String? token;
      if (useAuth) {
        token = "1|pC2jJqNY1vvVNVUuq3nh7CXqFEKtyxCvIhEhdetcb95afab1";
        //token = await storage.read(key: "token");
        //  if (token == null) throw Exception("token_not_found".tr);
      }

      var request = http.MultipartRequest("POST", Uri.parse(url));

      // الهيدر
      request.headers.addAll({
        "Accept": "application/json",
        if (useAuth) "Authorization": "Bearer $token",
      });

      // إضافة الحقول العادية
      request.fields.addAll(fields);

      // إضافة الملفات (الصور)
      if (files != null) {
        files.forEach((key, file) async {
          request.files.add(await http.MultipartFile.fromPath(key, file.path));
        });
      }

      // إرسال الطلب
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint("STATUS: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");

      dynamic body;
      try {
        body = jsonDecode(response.body);
      } catch (_) {
        body = response.body;
      }

      return {"statusCode": response.statusCode, "body": body};
    } catch (e) {
      debugPrint("ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  static Future<Uint8List?> downloadImage(String type) async {
    try {
      final url = Uri.parse(urlClient["getpictureProfile"]!);
      // final token = await ApiService.getToken(); // إذا عندك توكن
      final token = "1|pC2jJqNY1vvVNVUuq3nh7CXqFEKtyxCvIhEhdetcb95afab1";
      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        body: {"type": type},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Error status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }
}
