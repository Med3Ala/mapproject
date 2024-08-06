import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

const apiKey = "FHh9gFfl6vBRSuj5eWXi";
const styleUrl = "https://api.maptiler.com/maps/streets-v2/style.json";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 62, 149, 255)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [  
          Positioned(
            top: 0,
            left: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: MaplibreMap(
              styleString: "$styleUrl?key=$apiKey",
              myLocationEnabled: false,
              initialCameraPosition: const CameraPosition(target: LatLng(36, 10)),
              trackCameraPosition: true,

          )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              items: const [
                Icon(Icons.search),
                Icon(Icons.person),
                Icon(Icons.home),
                Icon(Icons.search),
                Icon(Icons.person),
              ],
              onTap: (index) {
                // Handle bottom navigation bar taps
              },
            ),
          )
        ],
      )
      
      
    );
  }
}
