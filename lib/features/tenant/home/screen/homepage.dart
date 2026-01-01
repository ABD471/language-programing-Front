import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:apartment_rental_system/common/widget/gradientbackground.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/apartmentListWithShimmer.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/buildCityChips.dart';
import 'package:apartment_rental_system/features/tenant/home/controller/homeController.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/skeletonCard.dart';
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
  bool _isFabExtended = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleFabExtension);
  }

  void _handleFabExtension() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isFabExtended) setState(() => _isFabExtended = false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isFabExtended) setState(() => _isFabExtended = true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: _isFabExtended,
        onPressed: () => openFilterSheet(
          context,
          priceRange: controller.priceRange.value,
          onPressedRest: controller.resetFilters,
          onChanged: controller.changePrice,
          onPressedApply: () => Navigator.pop(context),
        ),
        icon: const Icon(Icons.filter_list_rounded),
        label: Text(
          "filter".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GradientBackground(
        child: RefreshIndicator(
          onRefresh: () => controller.refreshApartments(),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      _buildSearchField(context),
                      const SizedBox(height: 16),
                      CityChipsTest(
                        cities: controller.availableCities,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return _buildLoadingState();
                }
                if (controller.filtered.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: ApartmentListWithShimmerTest(
                    controller: controller,
                    onTap: (apt) => controller.toDetiles(apt),
                  ),
                );
              }),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const SkeletonCard(),
          childCount: 3,
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: controller.changeSearch,
          decoration: InputDecoration(
            hintText: 'search_hint'.tr,
            prefixIcon: const Icon(Icons.search_rounded),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          'no_results'.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: controller.resetFilters,
          child: Text("reset_filters".tr),
        ),
      ],
    );
  }
}
