
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:imap/shape.dart';
import 'package:imap/utilities.dart';
import 'package:latlong2/latlong.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;


proj4.Projection webMercator = proj4.Projection.get('EPSG:4326')!;

class Mcircle extends Shape {
  LatLng center;
  double radius;

  CircleMarker circle = const CircleMarker(
    point: LatLng(0, 0),
    radius: 0,
    color: Colors.green,
    borderStrokeWidth: 2.0,
    borderColor: Colors.green,
  );

  static const Icon icon = Icon(
    Icons.fiber_manual_record_outlined,
    color: Colors.green,
    size: 25.0,
  );

  Marker centerMarker = const Marker(
    point: LatLng(0, 0),
    child: icon,
  );

  Mcircle({required this.center, required this.radius, color, strokeWidth}) : super(points: [], color: color, strokeWidth: strokeWidth){
    centerMarker = Marker(
      point: center,
      child: icon,
    );
  }

  @override
  List<LatLng> getCoordinates() {
    final points = <LatLng>[];
    return points;
  }

  setZoom(double zoomLevel) {
    this.zoomLevel = zoomLevel;
    print("zoomLevel: $zoomLevel");
  }

    // adding a second point so the circle can be drawn
  @override
  void addPoint(LatLng point) {
    points.add(point);

    final centerMercator = webMercator.forward(proj4.Point(x: center.latitude, y: center.longitude));
    final pointMercator = webMercator.forward(proj4.Point(x: point.latitude, y: point.longitude));

    final distanceInMeters = sqrt(
      pow(centerMercator.x - pointMercator.x, 2) +
      pow(centerMercator.y - pointMercator.y, 2)
    );

    circle = CircleMarker(
      point: center,
      radius: distanceInMeters * 50 * calculateScaleFactor(zoomLevel, center.latitude),
      useRadiusInMeter: true,
      color: Colors.greenAccent,
      borderStrokeWidth: 5.0,
      borderColor: Colors.green,
    );

    print("dist: $distanceInMeters");
  }

  @override
  void removePoint(int index) {
    // Not applicable for Circle
  }
}

double calculateScaleFactor(double zoomLevel, double latitude) {
  const equatorialCircumference = 40075016.686; // meters
  const tileWidth = 256;

  final stile = (equatorialCircumference * cos(latitude * (pi / 180))) / pow(2, zoomLevel);
  final spixel = stile / tileWidth;

  return spixel;
}
