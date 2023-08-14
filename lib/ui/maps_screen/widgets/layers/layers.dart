import 'package:dio_example/services/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void showMapTypeMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return const MapTypeMenu(); // Display the map type menu
    },
  );
}

class MapTypeMenu extends StatelessWidget {
  const MapTypeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Map Type',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<MapProvider>().setMapType(MapType.normal);
                  Navigator.pop(context);
                },
                child: const Text('Default'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<MapProvider>().setMapType(MapType.hybrid);
                  Navigator.pop(context);
                },
                child: const Text('Satellite'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<MapProvider>().setMapType(MapType.terrain);
                  Navigator.pop(context);
                },
                child: const Text('Terrain'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
