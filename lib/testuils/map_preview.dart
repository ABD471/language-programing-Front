import 'package:apartment_rental_system/testuils/contreeelrer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class MapPreviewTest extends StatelessWidget {
  final ApartmentDetailsControllerTest controller;
  const MapPreviewTest({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final LatLng pos = controller.location;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              height: 200,
              child: FlutterMap(
                options: MapOptions(initialCenter: pos, initialZoom: 8),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: pos,
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.apartment.address.city ?? 'الموقع غير متوفر',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton.icon(
                  onPressed: controller.openExternalMaps,
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('افتح في الخرائط'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
