import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/description_section.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/amenities_section.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/booking_button.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/contact_card.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/controller/apartmentDetailsController.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/header_image_carousel.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/map_preview.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/title_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApartmentDetailsScreenTest extends StatelessWidget {
  final ApartmentTest apartment;

  const ApartmentDetailsScreenTest({Key? key, required this.apartment})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final ctrl = Get.put(
      ApartmentDetailsControllerTest(apartment),
      tag: apartment.id.toString(),
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
     
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: isDark ? Colors.black54 : Colors.white70,
            child: BackButton(color: isDark ? Colors.white : Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: isDark ? Colors.black54 : Colors.white70,
              child: IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {}, // منطق المشاركة
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: ctrl.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // عرض الصور في الجزء العلوي
          SliverToBoxAdapter(child: HeaderImageCarouselTest(controller: ctrl)),

          SliverToBoxAdapter(
            child: Container(
              // سحب الحاوية للأعلى قليلاً لتتداخل مع الصور (Modern Look)
              transform: Matrix4.translationValues(0, -20, 0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان والسعر والتقييم
                    TitleSectionTest(apartment: apartment),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(thickness: 0.5),
                    ),

                    // الوصف
                    Text(
                      'عن هذه الشقة',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DescriptionSection(description: apartment.description),

                    const SizedBox(height: 24),

                    // المرافق (التجهيزات)
                    Text(
                      'ما الذي توفره الشقة؟',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AmenitiesSectionTest(apartment: apartment),

                    const SizedBox(height: 24),

                    // كارت التواصل مع صاحب العقار
                    ContactCardTest(controller: ctrl),

                    const SizedBox(height: 24),

                    // معاينة الموقع
                    Text(
                      'الموقع الجغرافي',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    MapPreviewTest(controller: ctrl),

                    // مساحة إضافية للزر السفلي
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // زر الحجز السفلي مثبت دائماً
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(child: BookingButtonTest(controller: ctrl)),
      ),
    );
  }
}
