import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/description_section.dart';
import 'package:apartment_rental_system/testuils/amenities_section.dart';

import 'package:apartment_rental_system/testuils/contact_card.dart';
import 'package:apartment_rental_system/testuils/contact_card_rentel.dart';
import 'package:apartment_rental_system/testuils/contreeelrer.dart';
import 'package:apartment_rental_system/testuils/header_image_carousel.dart';
import 'package:apartment_rental_system/testuils/map_preview.dart';
import 'package:apartment_rental_system/testuils/model/apartment.dart';
import 'package:apartment_rental_system/testuils/title_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApartmentDetailsScreenRental extends StatelessWidget {
  final ApartmentTest apartment;

  const ApartmentDetailsScreenRental({Key? key, required this.apartment})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ApartmentDetailsControllerTest(apartment));

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: ctrl.scrollController,
        slivers: [
          SliverToBoxAdapter(child: HeaderImageCarouselTest(controller: ctrl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSectionTest(apartment: apartment),
                  const SizedBox(height: 12),
                  DescriptionSection(description: apartment.description),
                  const SizedBox(height: 16),
                  AmenitiesSectionTest(apartment: apartment),
                  const SizedBox(height: 16),
                  ContactCardTestRentel(controller: ctrl),
                  const SizedBox(height: 16),
                  MapPreviewTest(controller: ctrl),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
