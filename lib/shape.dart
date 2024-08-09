import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

abstract class Shape {
  final List<LatLng> points;
  final Color? color;
  final double? strokeWidth;

  Shape({required this.points, this.color = Colors.blue, this.strokeWidth = 2.0});

  // Abstract methods for subclasses to implement
  List<LatLng> getCoordinates();
  void addPoint(LatLng point);
  void removePoint(int index);
}


class Polygon extends Shape {
  Polygon({required List<LatLng> points, color, strokeWidth}) : super(points: points, color: color, strokeWidth: strokeWidth);

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


class Polyline extends Shape {
  Polyline({required List<LatLng> points, color, strokeWidth}) : super(points: points, color: color, strokeWidth: strokeWidth);

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