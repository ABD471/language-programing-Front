import 'package:apartment_rental_system/common/model/Apartment.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  // ---------- Reactive Variables ----------
  var apartments = <Apartment>[].obs;
  var filtered = <Apartment>[].obs;
  var selectedCity = 'الكل'.obs;
  var priceRange = const RangeValues(0, 200000).obs;
  var searchQuery = ''.obs;
  var isLoading = true.obs;

  // ---------- Initialization ----------
  @override
  void onInit() {
    super.onInit();
    _loadApartments();
  }

  Future<void> refreshApartments() async {
    // يمكنك هنا عمل fetch جديد من API أو List.generate
    await Future.delayed(const Duration(seconds: 2));
    // بعد جلب البيانات:
    filtered.value = List.generate(
      50,
      (i) => Apartment(
        id: 'apt_$i',
        title: 'شقة ${(i % 3) + 1} غرفة',
        city: ['دمشق', 'اللاذقية', 'حلب', 'طرطوس'][i % 4],
        price: 20000 + i * 12000,
        imageUrl: 'https://picsum.photos/seed/$i/400/200',
        rating: 4.0 + (i % 5) * 0.15,
        description: '',
        amenities: [],
      ),
    );
  }

  // Future<void> refreshApartments() async {
  //   isLoading.value = true;
  //   await Future.delayed(const Duration(seconds: 1)); // محاكاة جلب بيانات
  //   // هنا ضع منطق إعادة جلب البيانات
  //   filtered.value = apartments; // على سبيل المثال
  //   isLoading.value = false;
  // }

  void setLoading(bool value) => isLoading.value = value;
  void _loadApartments() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final dummyApartments = List.generate(
      8,
      (i) => Apartment(
        id: 'apt_$i',
        title: 'شقة أنيقة - غرفة ${(i % 3) + 1}',
        city: ['دمشق', 'اللاذقية', 'حلب', 'طرطوس'][i % 4],
        price: 20000 + i * 12000,
        imageUrl: 'https://picsum.photos/seed/parallax$i/900/600',
        rating: 4.0 + (i % 5) * 0.15,
        description: '',
        amenities: [],
      ),
    );

    apartments.value = dummyApartments;
    _applyFilters();
    isLoading.value = false;
    // try {
    //   isLoading.value = true;

    //   final response = await ApiService.getRequest(
    //     url: urlClient["getApartments"]!, // مثال: api/apartment
    //     useAuth: true,
    //   );

    //   if (response["statusCode"] == 200) {
    //     final body = response["body"];

    //     final List apartmentsJson = body["apartments"]["data"];

    //     final List<Apartment> loadedApartments = apartmentsJson
    //         .map((e) => Apartment.fromJson(e))
    //         .toList();
    //     print("43rreggfdg");
    //     apartments.value = loadedApartments;
    //     _applyFilters();
    //   } else {
    //     Get.snackbar("خطأ", "فشل في جلب الشقق");
    //   }
    // } catch (e) {
    //   debugPrint("LOAD APARTMENTS ERROR: $e");
    //   Get.snackbar("خطأ", "حدث خطأ غير متوقع");
    // } finally {
    //   isLoading.value = false;
    // }
  }

  // ---------- Filter Logic ----------
  void _applyFilters() {
    filtered.value = apartments.where((a) {
      final matchesCity =
          selectedCity.value == 'الكل' || a.city == selectedCity.value;
      final withinPrice =
          a.price! >= priceRange.value.start &&
          a.price! <= priceRange.value.end;
      final matchesSearch =
          searchQuery.value.isEmpty ||
          a.title!.contains(searchQuery.value) ||
          a.city!.contains(searchQuery.value);
      return matchesCity && withinPrice && matchesSearch;
    }).toList();
  }

  void changeCity(String city) {
    selectedCity.value = city;
    _applyFilters();
  }

  void changePrice(RangeValues range) {
    priceRange.value = range;
    _applyFilters();
  }

  void changeSearch(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void resetFilters() {
    selectedCity.value = 'الكل';
    priceRange.value = const RangeValues(0, 200000);
    searchQuery.value = '';
    _applyFilters();
  }

  void onTapDetails(Apartment apt) {
    Get.toNamed('/apartment-details', arguments: apt);
  }
}
