
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'shape.dart';

class Dmarker extends Shape {
  late Marker obj;

  Dmarker({required List<LatLng> points, color, strokeWidth}):super(points: points, color: color, strokeWidth: strokeWidth){
    obj = Marker(
      point: points[0],
      child: const Icon(
          Icons.place,
          color: Colors.green,
          size: 25.0,
        ),
      );

      print("Dmarker: $points");
  }

  @override
  List<LatLng> getCoordinates() {
    return points;
  }

  @override
  void addPoint(LatLng point) {
    points.add(point);
  }

  @override
  void removePoint(int index) {
    points.removeAt(index);
  }
}