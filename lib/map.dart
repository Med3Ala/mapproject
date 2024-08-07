// map_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class MapWidget extends StatelessWidget {

  final String tileUrl;
  MapWidget({super.key, required this.tileUrl});


  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(34, 9.5),
        initialZoom: 6,
      ),
      children: [
        // Obx(() =>
        TileLayer( 
          urlTemplate: tileUrl, 
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19, 
        // )
        ),
        
      ],
    );
  }
}