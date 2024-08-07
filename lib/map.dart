// map_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class MapWidget extends StatefulWidget {

  var tileUrl = "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png";
  MapWidget(String value, {super.key, required this.tileUrl});

  final mapController = MapController();

    

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {


  @override
  Widget build(BuildContext context) {
    print("MapWidget: ${widget.tileUrl}");
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(34, 9.5),
        initialZoom: 6,
      ),
      children: [
        TileLayer( 
          urlTemplate: widget.tileUrl, 
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19, 
        ),
      ],
    );
  }
}
