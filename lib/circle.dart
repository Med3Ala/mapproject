
import 'dart:math';

import 'package:imap/shape.dart';
import 'package:latlong2/latlong.dart';

class Mcircle extends Shape {
  LatLng center;
  double radius;

  Mcircle({required this.center, required this.radius, color, strokeWidth}) : super(points: [], color: color, strokeWidth: strokeWidth);

  @override
  List<LatLng> getCoordinates() {
    final points = <LatLng>[];
    return points;
  }

  @override
  void addPoint(LatLng point) {
    // Adjust center and radius based on the added point
  }

  @override
  void removePoint(int index) {
    // Not applicable for Circle
  }
}
