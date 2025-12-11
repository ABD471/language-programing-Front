// -------------------------
// ParallaxApartmentCard, PriceTag, RatingStars, SkeletonCard, AnimatedFilterFAB
// -------------------------

import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/features/home/widget/priceTag.dart';
import 'package:apartment_rental_system/features/home/widget/ratingStars.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:flutter/material.dart';

class ParallaxApartmentCard extends StatefulWidget {
  final Apartment apartment;
  final VoidCallback? onTap;
  const ParallaxApartmentCard({super.key, required this.apartment, this.onTap});

  @override
  State<ParallaxApartmentCard> createState() => _ParallaxApartmentCardState();
}

class _ParallaxApartmentCardState extends State<ParallaxApartmentCard> {
  double _dy = 0;

  void _onPointerMove(PointerEvent e) =>
      setState(() => _dy = (e.distance - 100) / 1000);
  void _onPointerExit(PointerEvent e) => setState(() => _dy = 0);

  @override
  Widget build(BuildContext context) {
    final apt = widget.apartment;
    return Listener(
      onPointerHover: _onPointerMove,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerExit,
      onPointerCancel: _onPointerExit,
      child: GestureDetector(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(0, _dy * 30),
                child: Image.network(
                  apt.imageUrl!,
                  fit: BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apt.title!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${apt.city}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),
                          ),
                          PriceTag(amount: apt.price!),
                        ],
                      ),
                      const SizedBox(height: 4),
                      RatingStars(rating: apt.rating!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
