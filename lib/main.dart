import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:imap/map.dart';
import 'package:latlong2/latlong.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';

const apiKey = "FHh9gFfl6vBRSuj5eWXi";
const styleUrl = "https://api.maptiler.com/maps/satellite/style.json";

const tilesUrls = [
  "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png",
  "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
  "https://tiles.stadiamaps.com/tiles/alidade_satellite/{z}/{x}/{y}{r}.png",
  "https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png",
  "http://tile.mtbmap.cz/mtbmap_tiles/{z}/{x}/{y}.png",
];


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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

  var tileUrl = "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png".obs;


  final mapController = MapController();
  

      // Future<Style> _loadStyle() async {
      //   // final jsonString = await rootBundle.loadString('./style.json');
      //   // final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      //   return StyleReader(
      //     uri: "./style.json",
      //     apiKey: apiKey,
      //   ).read();
      // }

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
            child: Obx(()=> MapWidget(tileUrl.value, tileUrl: tileUrl.value)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:  CurvedNavigationBar(
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
                tileUrl.value = tilesUrls[index];
                print('Tapped index: $index');
              },
            ),
          ),
        ],
        )
      
      
    );
  }
}
