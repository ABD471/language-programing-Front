
// ------------------- شاشة التفاصيل -------------------


import 'package:apartment_rental_system/common/model/Apartment.dart';
import 'package:apartment_rental_system/theme/maintheme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';



class ApartmentDetailsScreen extends StatelessWidget {
  final Apartment apartment;

  // صور إضافية (يمكنك التعديل لاحقاً لتصبح جزء من البيانات)
  final List<String> images = const [
    "https://images.unsplash.com/photo-1502672023488-70e25813eb80",
    "https://images.unsplash.com/photo-1527030280862-64139fba04ca",
    "https://images.unsplash.com/photo-1505691938895-1758d7feb511",
  ];

  const ApartmentDetailsScreen({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    // إضافة الصورة الرئيسية ضمن القائمة
    final List<String> allImages = [apartment.imageUrl, ...images];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider(
                items: allImages
                    .map(
                      (img) => Image.network(
                        img,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 1,
                  autoPlay: true,
                ),
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // ---- تفاصيل المحتوى ----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان + السعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          apartment.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${apartment.price.toInt()} ل.س',
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'في الليلة',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        apartment.city,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 40),

                  // -------- معرض الصور الجانبي المصغّر --------
                  const Text(
                    "المعرض",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: allImages
                          .map(
                            (img) => Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(img),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  const Divider(height: 40),

                  // ------------------- المرافق -------------------
                  const Text(
                    'المرافق',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: apartment.amenities
                        .map(
                          (item) => Chip(
                            label: Text(item),
                            backgroundColor: AppTheme.primary.withOpacity(0.1),
                            labelStyle: const TextStyle(
                              color: AppTheme.primary,
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const Divider(height: 40),

                  // ------------------- الوصف -------------------
                  const Text(
                    'الوصف',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    apartment.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------- خريطة Google -------------------
                  const Text(
                    'الموقع على الخريطة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: // ------------------- خريطة OSM -------------------
                      Column(
                        children: [
                          const Text(
                            'الموقع على الخريطة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 210,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FlutterMap(
                                options: MapOptions(
                                  initialCenter: LatLng(
                                    33.5138,
                                    36.2765,
                                  ), // ← ضع إحداثيات شقتك
                                  initialZoom: 14,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    userAgentPackageName: "com.example.test",
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: LatLng(
                                          33.5138,
                                          36.2765,
                                        ), // ← نفس الإحداثيات
                                        width: 40,
                                        height: 40,
                                        child: const Icon(
                                          Icons.location_pin,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // زر الحجز السفلي
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إرسال طلب الحجز للمالك بانتظار الموافقة'),
              ),
            );
          },
          child: const Text('احجز الآن', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}