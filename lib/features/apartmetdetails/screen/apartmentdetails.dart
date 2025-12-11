import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/features/apartmetdetails/controller/apartmentDetailsController.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/amenities_section.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/booking_button.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/calendar_section.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/contact_card.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/description_section.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/header_image_carousel.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/map_preview.dart';
import 'package:apartment_rental_system/features/apartmetdetails/widget/title_section.dart';
import 'package:apartment_rental_system/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  // يتوقع أن يتم وضع Binding قبل فتح هذه الشاشة أو استدعاء Controller يدوياً
  ApartmentDetailsScreen({Key? key, required Apartment apartment}) : super(key: key);

  final ApartmentDetailsController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    
    
    final apt = ctrl.apartment;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: ctrl.scrollController,
        slivers: [
          SliverToBoxAdapter(child: HeaderImageCarousel(controller: ctrl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSection(apartment: apt),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AmenitiesSection(amenities: apt.amenities!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DescriptionSection(description: apt.description!),
                  const SizedBox(height: 16),
                  CalendarSection(controller: ctrl),
                  const SizedBox(height: 16),
                  ContactCard(controller: ctrl),
                  const SizedBox(height: 16),
                  MapPreview(controller: ctrl),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookingButton(controller: ctrl),
    );
  }
}
