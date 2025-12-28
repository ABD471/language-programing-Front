import 'package:apartment_rental_system/features/tenant/home/widget/customChoiceChipState.dart';
import 'package:apartment_rental_system/features/tenant/home/widget/parallaxApartmentCard.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';

void openFilterSheet(
  BuildContext context, {
  required RangeValues priceRange,
  required void Function() onPressedRest,
  required void Function() onPressedApply,
  required void Function(RangeValues value) onChanged,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: DraggableScrollableSheet(
          initialChildSize: 0.45,
          minChildSize: 0.25,
          maxChildSize: 0.92,
          builder: (context, sc) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.all(18),
              child: ListView(
                controller: sc,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'تصفية النتائج',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'نطاق السعر (ل.س)',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: priceRange.start,
                    max: priceRange.end,
                    divisions: 20,
                    labels: RangeLabels(
                      '${priceRange.start.round()}',
                      '${priceRange.end.round()}',
                    ),

                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (RangeValues value) {
                      onChanged(value);
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'حجم الشقة',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      CustomChoiceChip(label: '1 غرفة', selected: false),
                      CustomChoiceChip(label: '2 غرفة', selected: false),
                      CustomChoiceChip(label: '3 غرفة', selected: false),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onPressedApply();
                          },
                          child: const Text('تطبيق'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          onPressedRest();
                        },

                        child: const Text('إعادة'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'نتائج مشابهة',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 200,
                          child: ParallaxApartmentCard(
                            apartment: dummyApartments[i],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
