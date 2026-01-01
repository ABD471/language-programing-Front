

import 'package:apartment_rental_system/features/tenant/home/model/apartment.dart';
import 'package:flutter/material.dart';

void openDetails(BuildContext context, ApartmentTest apt) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
        //  child: ApartmentDetails(apartment: apt),
        ),
      ),
    );
  }