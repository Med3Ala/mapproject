import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

const apiKey = "FHh9gFfl6vBRSuj5eWXi";
const styleUrl = "https://api.maptiler.com/maps/f6a7b4d0-b349-4cb0-843f-9d70be0cdb5c/style.json";

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

      Future<Style> _readStyle() => StyleReader(
          uri: "${styleUrl}?key=${apiKey}",
          // ignore: undefined_identifier
          apiKey: apiKey)
      .read();

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
            child: FutureBuilder<Style>(
              future: _readStyle(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Or any loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final style = snapshot.data!; // Access the fetched style

                  //final style = snapshot.data!;

                  return FlutterMap(
                    options: MapOptions(
                      initialCenter: const LatLng(31.050478, -7.931633),
                      initialZoom: 12.0,
                    ),
                    children: [
                      VectorTileLayer(
                        theme: style.theme,
                        sprites: style.sprites,
                        // tileOffset: TileOffset.mapbox, enable with mapbox
                        tileProviders: style.providers,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
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
          ),
        ],
        )
      
      
    );
  }
}
