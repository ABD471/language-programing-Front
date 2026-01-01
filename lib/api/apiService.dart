import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/helper/const/requestType.dart';

import 'package:apartment_rental_system/util/service/authservice.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // ================== HEADERS ==================
  static Map<String, String> _headers({bool useAuth = false}) {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      if (useAuth && AuthService.token != null)
        "Authorization": "Bearer ${AuthService.token}",
    };
  }

  // ================== POST ==================
  static Future<Map<String, dynamic>> postRequest({
    required String url,
    Map<String, dynamic>? payload,
    bool useAuth = false,
    RequestType type = RequestType.normal,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _headers(useAuth: useAuth),
            body: jsonEncode(payload ?? {}),
          )
          .timeout(getTimeout(type));

      return _handleResponse(response);
    } on SocketException {
      throw Exception("no_internet".tr);
    } on TimeoutException {
      throw Exception("timeout".tr);
    } catch (e) {
      debugPrint("POST ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  // ================== GET ==================
  static Future<Map<String, dynamic>> getRequest({
    required String url,
    bool useAuth = false,
    RequestType type = RequestType.normal,
  }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: _headers(useAuth: useAuth))
          .timeout(getTimeout(type));

      return _handleResponse(response);
    } on SocketException {
      throw Exception("no_internet".tr);
    } on TimeoutException {
      throw Exception("timeout".tr);
    } catch (e) {
      debugPrint("GET ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  // ================== MULTIPART ==================
  static Future<Map<String, dynamic>> postMultipartRequest({
    required String url,
    required Map<String, String> fields,
    Map<String, File>? files,
    bool useAuth = false,
  }) async {
    try {
      final request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers.addAll({
        "Accept": "application/json",
        if (useAuth && AuthService.token != null)
          "Authorization": "Bearer ${AuthService.token}",
      });

      request.fields.addAll(fields);

      if (files != null) {
        for (final entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value.path),
          );
        }
      }

      final streamed = await request.send().timeout(
        getTimeout(RequestType.upload),
      );

      final response = await http.Response.fromStream(streamed);

      return _handleResponse(response);
    } on SocketException {
      throw Exception("no_internet".tr);
    } on TimeoutException {
      throw Exception("timeout".tr);
    } catch (e) {
      debugPrint("MULTIPART ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  // ================== DOWNLOAD ==================

  static Future<Uint8List?> downloadImage({
    required String url,
    Map<String, dynamic>? payload,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(urlClient[url]!),
            headers: {
              "Accept": "*/*",
              if (AuthService.token != null)
                "Authorization": "Bearer ${AuthService.token}",
            },
            body: payload,
          )
          .timeout(getTimeout(RequestType.download));

      return response.statusCode == 200 ? response.bodyBytes : null;
    } catch (e) {
      debugPrint("DOWNLOAD ERROR: $e");
      return null;
    }
  }

  // ================== DELETE ==================
  static Future<Map<String, dynamic>> deleteRequest({
    required String url,
    Map<String, dynamic>? payload,
    bool useAuth = false,
    RequestType type = RequestType.normal,
  }) async {
    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: _headers(useAuth: useAuth),
            body: payload != null ? jsonEncode(payload) : null,
          )
          .timeout(getTimeout(type));
      final body = response.body;
      print("response :$body ");
      return _handleResponse(response);
    } on SocketException {
      throw Exception("no_internet".tr);
    } on TimeoutException {
      throw Exception("timeout".tr);
    } catch (e) {
      debugPrint("DELETE ERROR: $e");
      throw Exception("unexpected_error".tr);
    }
  }

  // ================== RESPONSE HANDLER ==================
  static Map<String, dynamic> _handleResponse(http.Response response) {
    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {
      body = response.body;
    }

    return {"statusCode": response.statusCode, "body": body};
  }

  static Duration getTimeout(RequestType type) {
    switch (type) {
      case RequestType.splash:
        return const Duration(seconds: 3);
      case RequestType.upload:
        return const Duration(seconds: 30);
      case RequestType.download:
        return const Duration(seconds: 55);
      case RequestType.normal:
      default:
        return const Duration(seconds: 50);
    }
  }
}
