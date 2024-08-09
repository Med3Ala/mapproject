import 'dart:math';

import 'package:latlong2/latlong.dart';

// calc distance between two latlngs
double calcDist(LatLng p1, LatLng p2) {
  
  return sqrt(
    pow(p1.latitude - p2.latitude, 2) + 
    pow(p1.longitude - p2.longitude, 2)
  );
}