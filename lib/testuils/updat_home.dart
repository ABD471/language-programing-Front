// import 'dart:ui';
// import 'package:apartment_rental_system/common/model/Apartment.dart';
// import 'package:apartment_rental_system/features/home/widget/animatedFilterFAB.dart';
// import 'package:apartment_rental_system/features/home/widget/animatedSearchBox.dart';
// import 'package:apartment_rental_system/features/home/widget/buildAnimatedList.dart';
// import 'package:apartment_rental_system/features/home/widget/customChoiceChipState.dart';
// import 'package:apartment_rental_system/features/home/widget/openFilterSheet.dart';
// import 'package:apartment_rental_system/features/home/widget/parallaxApartmentCard.dart';
// import 'package:apartment_rental_system/features/home/widget/skeletonCard.dart';
// import 'package:apartment_rental_system/theme/maintheme.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const TestApp());
// }

// class TestApp extends StatelessWidget {
//   const TestApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'تطبيق إيجار',
//       theme: AppTheme.theme,
//       builder: (context, child) =>
//           Directionality(textDirection: TextDirection.rtl, child: child!),
//       home: const AdvancedHomeScreen(),
//     );
//   }
// }

// // -------------------------
// // Dummy model + data
// // -------------------------

// final dummyApartments = List.generate(
//   8,
//   (i) => Apartment(
//     id: 'apt_$i',
//     title: 'شقة أنيقة - غرفة ${(i % 3) + 1}',
//     city: ['دمشق', 'اللاذقية', 'حلب', 'طرطوس'][i % 4],
//     price: 20000 + i * 12000,
//     imageUrl: 'https://picsum.photos/seed/parallax$i/900/600',
//     rating: 4.0 + (i % 5) * 0.15,
//     description: '',
//     amenities: [],
//   ),
// );

// // -------------------------
// // Main Home Screen
// // -------------------------
// class AdvancedHomeScreen extends StatefulWidget {
//   const AdvancedHomeScreen({super.key});

//   @override
//   State<AdvancedHomeScreen> createState() => _AdvancedHomeScreenState();
// }

// class _AdvancedHomeScreenState extends State<AdvancedHomeScreen>
//     with TickerProviderStateMixin {
//   String selectedCity = 'الكل';
//   RangeValues priceRange = const RangeValues(0, 200000);
//   String searchQuery = '';

//   late final ScrollController _scrollController;
//   late final AnimationController _fabController;
//   late final AnimationController listController;

//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _fabController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 350),
//     );
//     listController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     Future.delayed(const Duration(milliseconds: 800), () {
//       setState(() => _isLoading = false);
//       listController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _fabController.dispose();
//     listController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filtered = dummyApartments.where((a) {
//       final matchesCity = selectedCity == 'الكل' || a.city == selectedCity;
//       final withinPrice =
//           a.price >= priceRange.start && a.price <= priceRange.end;
//       final matchesSearch =
//           searchQuery.isEmpty ||
//           a.title.contains(searchQuery) ||
//           a.city.contains(searchQuery);
//       return matchesCity && withinPrice && matchesSearch;
//     }).toList();

//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       floatingActionButton: AnimatedFilterFAB(
//         controller: _fabController,
//         onTap: () => openFilterSheet(
//           context,
//           priceRange: RangeValues(0, 1000000),
//           onPressed: () {
//             setState(() {
//               () => priceRange = const RangeValues(0, 200000);
//             });
//           },
//           onChanged: (value) {
//             setState(() => priceRange = value);
//           },
//         ),
//       ),
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             expandedHeight: 260,
//             backgroundColor: Colors.transparent,
//             automaticallyImplyLeading: false,
//             flexibleSpace: LayoutBuilder(
//               builder: (context, constraints) {
//                 final top = constraints.biggest.height;
//                 final collapsed =
//                     top <=
//                     kToolbarHeight + MediaQuery.of(context).padding.top + 10;
//                 return Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Positioned.fill(
//                       child: Image.network(
//                         'https://picsum.photos/seed/header/1200/800',
//                         fit: BoxFit.cover,
//                         alignment: Alignment(0, collapsed ? -0.3 : 0),
//                       ),
//                     ),
//                     Positioned.fill(
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Colors.black.withOpacity(0.15),
//                                 Colors.black.withOpacity(0.05),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 16,
//                       right: 16,
//                       bottom: 20,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           AnimatedOpacity(
//                             opacity: 1.0,
//                             duration: const Duration(milliseconds: 300),
//                             child: Text(
//                               'مرحباً، أحمد 👋',
//                               style: Theme.of(context).textTheme.bodyMedium
//                                   ?.copyWith(color: Colors.white70),
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             'ابحث عن شقتك القادمة',
//                             style: Theme.of(context).textTheme.headlineSmall
//                                 ?.copyWith(
//                                   color: Colors.white,
//                                   fontSize: collapsed ? 18 : 26,
//                                 ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white24,
//                                   borderRadius: BorderRadius.circular(
//                                     AppTheme.borderRadius,
//                                   ),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.location_on,
//                                       color: Colors.white,
//                                       size: 16,
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       'موقعك: دمشق',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium
//                                           ?.copyWith(color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: AnimatedSearchBox(
//                     onChanged: (v) => setState(() => searchQuery = v),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 SizedBox(height: 68, child: _buildCityList()),
//               ],
//             ),
//           ),
//           _isLoading ? _buildSkeletonList() : buildAnimatedList(filtered: filtered,animationController: listController),
//           const SliverToBoxAdapter(child: SizedBox(height: 80)),
//         ],
//       ),
//     );
//   }

//   Widget _buildCityList() {
//     final cities = ['الكل', 'دمشق', 'اللاذقية', 'حلب', 'طرطوس'];
//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       scrollDirection: Axis.horizontal,
//       itemCount: cities.length,
//       separatorBuilder: (_, __) => const SizedBox(width: 8),
//       itemBuilder: (context, i) {
//         final city = cities[i];
//         final selected = city == selectedCity;
//         return GestureDetector(
//           onTap: () => setState(() => selectedCity = city),
//           child: CustomChoiceChip(label: city, selected: selected),
//         );
//       },
//     );
//   }

//   Widget _buildSkeletonList() {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate((context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: SkeletonCard(),
//         );
//       }, childCount: 4),
//     );
//   }

  
//   void _openDetails(BuildContext context, Apartment apt) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 420),
//         pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
//           opacity: animation,
//           child: ApartmentDetails(apartment: apt),
//         ),
//       ),
//     );
//   }
// }

// // -------------------------
// // Widgets المحدثة لاستخدام Theme
// // -------------------------

// // Dummy ApartmentDetails page
// class ApartmentDetails extends StatelessWidget {
//   final Apartment apartment;
//   const ApartmentDetails({super.key, required this.apartment});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(apartment.title)),
//       body: Center(child: Text('تفاصيل الشقة هنا')),
//     );
//   }
// }
