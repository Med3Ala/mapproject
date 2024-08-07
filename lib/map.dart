// map_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

const apiKey = "FHh9gFfl6vBRSuj5eWXi";
const styleUrl = "https://api.maptiler.com/maps/f6a7b4d0-b349-4cb0-843f-9d70be0cdb5c/style.json";

class MapWidget extends StatefulWidget {
  final Style style; // Pass the style as an argument

  const MapWidget({super.key, required this.style});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(31.050478, -7.931633),
        initialZoom: 12.0,
      ),
      children: [
        VectorTileLayer(
          theme: widget.style.theme,
          sprites: widget.style.sprites,
          tileProviders: widget.style.providers,
        ),
      ],
    );
  }
}
