// map_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:imap/dMarker.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

import 'shape.dart';
import 'circle.dart';

typedef HitValue = ({String title, String subtitle});

class MapWidget extends StatefulWidget {

  var tileUrl = "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png";
  MapWidget(String value, {super.key, required this.tileUrl});

  final mapController = MapController();

  double zoomLevel = 6.0;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<Shape> shapes = [];
  String drawAction = '';
  @override
  Widget build(BuildContext context) {
    print("MapWidget: ${widget.tileUrl}");
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(34, 9.5),
        initialZoom: widget.zoomLevel,
        onTap: (point, latlng) {
          switch(drawAction) {
            case 'drawMarker':
              shapes.add(Dmarker(points: [latlng], color: Colors.red));
              setState(() {
                drawAction = '';
              });
              break;
            case 'drawCircle':
              shapes.add(Mcircle(center: latlng, radius: 0, color: Colors.red));
              setState(() {
                drawAction = 'drawCircle1';
              });
              break;
            case 'drawCircle1':
              final circle = shapes.last as Mcircle;
              circle.setZoom(widget.zoomLevel);
              circle.addPoint(latlng);
              setState(() {
                drawAction = '';
              });
              break;
          }
          
        },
        onPositionChanged: (position, hasGesture) {
          widget.zoomLevel = position.zoom;
        },
      ),
      children: [
        TileLayer( 
          urlTemplate: widget.tileUrl, 
          userAgentPackageName: 'com.example.app',
          maxNativeZoom: 19, 
        ),
        CircleLayer(
          circles: [...shapes.whereType<Mcircle>().map((shape) => shape.circle)],
        ),
        MarkerLayer(
          markers: [
            ...shapes.whereType<Mcircle>().map((shape) => shape.centerMarker),
            ...shapes.whereType<Dmarker>().map((shape) => shape.obj),
            const Marker(
              width: 25.0,
              height: 25.0,
              point: LatLng(34, 9.5),
              rotate: true,
              
              child: Icon(
                Icons.place,
                color: Colors.red,
                size: 25.0,
              ),
            ),
          ],
        ),
        PopupMenuButton(
          onSelected: (value) {
            drawAction = value;
          },
          icon: const Icon(Icons.menu, color: Colors.white),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(value: 'drawMarker', child: Text('Pin Marker')),
            PopupMenuItem<String>(value: 'drawCircle', child: Text('Draw Circle')),
          ],
        ),
        DragMarkers(
          markers: [
          DragMarker(
            point: LatLng(30,8),
            offset: const Offset(0.0, -8.0),
            builder: (context, point, state) => const Icon(Icons.location_on, size: 50),
            onDragUpdate: (details, latLng) => print(latLng),
            size: Size(50, 50),
          ),
        ],
        )
      ],
    );
    
  }
}
