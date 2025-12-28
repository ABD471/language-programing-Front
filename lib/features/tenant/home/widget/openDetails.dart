 import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/testuils/updat_home.dart';
import 'package:flutter/material.dart';

void openDetails(BuildContext context, Apartment apt) {
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