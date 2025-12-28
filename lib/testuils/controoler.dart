import 'package:apartment_rental_system/testuils/model/apartment.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:flutter/material.dart';

class HomeTestController extends GetxController {
  var apartments = <ApartmentTest>[].obs;
  var filtered = <ApartmentTest>[].obs;
  var selectedCity = 'الكل'.obs;
  var priceRange = const RangeValues(0, 200000).obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadApartmentsFromServer();
  }

  Future<void> refreshApartments() async {
    await loadApartmentsFromServer();
  }

  // ---------------- Load Apartments ----------------
  Future<void> loadApartmentsFromServer() async {
    try {
      isLoading.value = true;

      final response = await ApiService.getRequest(
        url: urlClient["getApartments"]!,
        useAuth: true,
      );

      if (response["statusCode"] == 200) {
        final List list = response["body"]["apartments"]["data"];

        final List<ApartmentTest> loadedApartments = [];

        for (final item in list) {
          try {
            loadedApartments.add(ApartmentTest.fromJson(item));
          } catch (e) {
            debugPrint('❌ ERROR PARSING ITEM ❌');
            debugPrint(item.toString());
            rethrow;
          }
        }

        apartments.assignAll(loadedApartments);
        filtered.assignAll(apartments);
        print(filtered.first.images.first.url);
        // applyFilters();
      } else {
        Get.snackbar("خطأ", "فشل في جلب الشقق");
      }
    } catch (e) {
      debugPrint("LOAD APARTMENTS ERROR: $e");
      Get.snackbar("خطأ", "حدث خطأ غير متوقع");
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- Filters ----------------
  void applyFilters() {
    filtered.assignAll(
      apartments.where((a) {
        final matchesCity =
            selectedCity.value == 'الكل' ||
            a.address.city == selectedCity.value;

        final priceValue = double.tryParse(a.price) ?? 0;
        final withinPrice =
            priceValue >= priceRange.value.start &&
            priceValue <= priceRange.value.end;

        final matchesSearch =
            searchQuery.value.isEmpty ||
            a.title.contains(searchQuery.value) ||
            a.address.city.contains(searchQuery.value);

        return matchesCity && withinPrice && matchesSearch;
      }).toList(),
    );
  }

  void changeCity(String city) {
    selectedCity.value = city;
    applyFilters();
  }

  void changePrice(RangeValues range) {
    priceRange.value = range;
    applyFilters();
  }

  void changeSearch(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void resetFilters() {
    selectedCity.value = 'الكل';
    priceRange.value = const RangeValues(0, 200000);
    searchQuery.value = '';
    applyFilters();
  }

  List<String> get availableCities {
    final set = apartments.map((a) => a.address.city).toSet();
    return ['الكل', ...set];
  }

  void toDetiles(ApartmentTest apt) {
    Get.toNamed("/apartment-details", arguments: apt);
  }
}
