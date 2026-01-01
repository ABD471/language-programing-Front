import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/description_section.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/amenities_section.dart';

import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/contact_card_rentel.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/controller/apartmentDetailsController.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/header_image_carousel.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/map_preview.dart';
import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:apartment_rental_system/features/tenant/apartmetdetails/widget/title_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ApartmentDetailsScreenRental extends StatelessWidget {
  final ApartmentTest apartment;

  const ApartmentDetailsScreenRental({Key? key, required this.apartment})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ApartmentDetailsControllerTest(apartment));

    return Scaffold(
      body: CustomScrollView(
        controller: ctrl.scrollController,
        slivers: [
          SliverToBoxAdapter(child: HeaderImageCarouselTest(controller: ctrl)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSectionTest(apartment: apartment),
                  SizedBox(height: 1.5.h),
                  DescriptionSection(description: apartment.description.tr),
                  SizedBox(height: 2.h),
                  AmenitiesSectionTest(apartment: apartment),
                  SizedBox(height: 2.h),
                  ContactCardTestRentel(controller: ctrl),
                  SizedBox(height: 2.h),
                  MapPreviewTest(controller: ctrl),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
