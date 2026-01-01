import 'package:apartment_rental_system/main.dart';

class AuthService {
  static String? token;
  static String? role;
  static String? userId;

  static Future<void> loadToken() async {
    token = await storage.read(key: "token");
    role = await storage.read(key: "role");
    userId = await storage.read(key: "userId");
  }

  static Future<void> setToken(
    String valuetoken,
    String valueRole,
    String valueId,
  ) async {
    token = valuetoken;
    role = valueRole;
    userId = valueId;
    await storage.write(key: "token", value: valuetoken);
    await storage.write(key: "role", value: valueRole);
    await storage.write(key: "userId", value: valueId);
  }

  static Future<void> clearToken() async {
    token = null;
    role = null;
    userId = null;

    await storage.delete(key: "token");
    await storage.delete(key: "role");
    await storage.delete(key: "userId");
  }
}
