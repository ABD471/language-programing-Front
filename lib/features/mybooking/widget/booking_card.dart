import 'package:apartment_rental_system/features/mybooking/controller/myBookingController.dart';
import 'package:flutter/material.dart';
import '../../../theme/maintheme.dart';

import 'action_button.dart';
import 'status_badge.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final apartment = widget.booking.apartment;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -5.0 : 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(_isHovered ? 0.2 : 0.05),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  apartment.imageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان و الحالة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            apartment.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        StatusBadge(status: widget.booking.status),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          widget.booking.dates,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 6),
                        Text(apartment.location ?? "غير متوفر"),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ActionButton(
                          icon: Icons.remove_red_eye,
                          text: 'التفاصيل',
                          color: AppTheme.primary,
                          onTap: () {},
                        ),
                        if (widget.booking.status == BookingStatus.pending)
                          ActionButton(
                            icon: Icons.close,
                            text: 'إلغاء',
                            color: Colors.red,
                            onTap: () {},
                          ),
                        if (widget.booking.status == BookingStatus.completed)
                          ActionButton(
                            icon: Icons.star,
                            text: 'تقييم',
                            color: Colors.amber,
                            onTap: () {},
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
