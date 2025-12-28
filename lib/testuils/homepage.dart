import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:apartment_rental_system/testuils/apartmentListWithShimmer.dart';
import 'package:apartment_rental_system/testuils/buildCityChips.dart';
import 'package:apartment_rental_system/testuils/controoler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/openFilterSheet.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/buildSliverAppBar.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({super.key});

  @override
  State<HomeTest> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeTest> with TickerProviderStateMixin {
  final HomeTestController controller = Get.put(HomeTestController());

  late final ScrollController _scrollController;
  late final AnimationController fabController;
  late final AnimationController listController;

  final List<String> cities = ['الكل', 'دمشق', 'اللاذقية', 'حلب', 'طرطوس'];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    fabController.dispose();
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('FILTERED COUNT: ${controller.filtered.length}');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: AnimatedBuilder(
        animation: fabController,
        builder: (context, child) {
          return Transform.rotate(
            angle: fabController.value * 0.1,
            child: Transform.scale(
              scale: 1 - fabController.value * 0.1,
              child: child,
            ),
          );
        },
        child: FloatingActionButton(
          onPressed: () {
            if (fabController.status == AnimationStatus.completed) {
              fabController.reverse();
            } else {
              fabController.forward();
            }

            openFilterSheet(
              context,
              priceRange: controller.priceRange.value,
              onPressedRest: controller.resetFilters,
              onChanged: controller.changePrice,
              onPressedApply: () => Navigator.pop(context),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.filter_list),
        ),
      ),
      body: GradientBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.refreshApartments();
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics:
                const AlwaysScrollableScrollPhysics(), // ✅ اجعل الـ CustomScrollView قابل للسحب دائمًا
            slivers: [
              buildSliverAppBar(),

              // البحث و الـ City Chips
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'ابحث عن مدينة أو منطقة',
                        ),
                        onChanged: controller.changeSearch,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CityChipsTest(
                      cities: controller.availableCities,
                      controller: controller,
                    ),
                  ],
                ),
              ),

              // حالة عدم وجود بيانات
              Obx(() {
                if (controller.isLoading.value) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const SizedBox(
                        height: 180,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      childCount: 4,
                    ),
                  );
                }

                if (controller.filtered.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: const Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                }

                return ApartmentListWithShimmerTest(
                  controller: controller,
                  onTap: (apt) {
                    controller.toDetiles(apt);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
