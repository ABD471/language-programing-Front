import 'package:apartment_rental_system/features/tenant/home/widget/customChoiceChipState.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

void openFilterSheet(
  BuildContext context, {
  required RangeValues priceRange,
  required void Function() onPressedRest,
  required void Function() onPressedApply,
  required void Function(RangeValues value) onChanged,
}) async {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 400),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, sc) {
          return Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1A1A1A)
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4.h),
              ), // Resize
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 1.5.h), // Resize
                Container(
                  width: 10.w, // Resize
                  height: 0.5.h, // Resize
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: sc,
                    padding: EdgeInsets.all(6.w), // Resize
                    children: [
                      Text(
                        'filter_results'.tr, // Translation
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp, // Resize
                        ),
                      ),
                      SizedBox(height: 3.h),
                      _buildPriceSection(theme, priceRange, onChanged),
                      SizedBox(height: 3.h),
                      Text(
                        'apartment_size'.tr, // Translation
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      _buildSizeChips(),
                      SizedBox(height: 5.h),
                      _buildActionButtons(
                        context,
                        theme,
                        onPressedApply,
                        onPressedRest,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildPriceSection(
  ThemeData theme,
  RangeValues priceRange,
  Function(RangeValues) onChanged,
) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'price_range'.tr,
            style: TextStyle(fontSize: 12.sp),
          ), // Translation
          Text(
            '${priceRange.start.round()} - ${priceRange.end.round()} ${'currency'.tr}',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
      SizedBox(height: 1.h),
      RangeSlider(
        values: priceRange,
        min: 0,
        max: 10000000,
        divisions: 50,
        activeColor: theme.colorScheme.primary,
        inactiveColor: theme.colorScheme.primary.withOpacity(0.1),
        onChanged: onChanged,
      ),
    ],
  );
}

Widget _buildSizeChips() {
  return Wrap(
    spacing: 2.w, // Resize
    runSpacing: 1.h, // Resize
    children: [
      CustomChoiceChip(label: 'studio'.tr, selected: false),
      CustomChoiceChip(label: 'room_hall'.tr, selected: true),
      CustomChoiceChip(label: 'two_rooms'.tr, selected: false),
      CustomChoiceChip(label: 'three_rooms_plus'.tr, selected: false),
    ],
  );
}

Widget _buildActionButtons(
  BuildContext context,
  ThemeData theme,
  VoidCallback onApply,
  VoidCallback onReset,
) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 1.8.h), // Resize
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          onPressed: () {
            onApply();
            Navigator.pop(context);
          },
          child: Text(
            'apply_filter'.tr, // Translation
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(width: 3.w),
      Expanded(
        flex: 1,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 1.8.h), // Resize
            side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.5)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onReset,
          child: Text(
            'reset'.tr,
            style: TextStyle(fontSize: 12.sp),
          ), // Translation
        ),
      ),
    ],
  );
}
