import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../theme/maintheme.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: theme.highlightColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.9)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        tabs: const [
          Tab(icon: Icon(Iconsax.clock, size: 18), text: 'الحالية'),
          Tab(icon: Icon(Iconsax.tick_circle, size: 18), text: 'السابقة'),
          Tab(icon: Icon(Iconsax.close_circle, size: 18), text: 'الملغاة'),
        ],
      ),
    );
  }
}
