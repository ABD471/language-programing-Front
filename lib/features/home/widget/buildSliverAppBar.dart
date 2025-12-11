import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';

Widget buildSliverAppBar() {
  return SliverAppBar(
    pinned: false,
    expandedHeight: 200,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.biggest.height;
        final collapsed =
            top <= kToolbarHeight + MediaQuery.of(context).padding.top + 10;

        return Stack(
          fit: StackFit.expand,
          children: [
            // الصورة الخلفية
            Positioned.fill(
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                alignment: Alignment(0, collapsed ? -0.3 : 0),
              ),
            ),
            // طبقة الـ Blur مع Gradient
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.25), // أكثر وضوحًا عند الطمس
                        Colors.black.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // محتوى الـ AppBar
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      'مرحباً، أحمد 👋',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'ابحث عن شقتك القادمة',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontSize: collapsed ? 18 : 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadius,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'موقعك: دمشق',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}
