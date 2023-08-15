import 'package:dio_example/services/provider/db_provider.dart';
import 'package:dio_example/services/provider/map_provider.dart';
import 'package:dio_example/ui/maps_screen/widgets/layers/layers.dart';
import 'package:dio_example/ui/maps_screen/widgets/show_place_info/show_info.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.lat, required this.long});
  final double lat;
  final double long;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition myLocation;

  @override
  void initState() {
    super.initState();
       
    myLocation = CameraPosition(
      target: LatLng(widget.lat, widget.long),
      zoom: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            
            onTap: (argument) {
              context.read<MapProvider>().updateLatLngAndAddMArker(argument);
              context
                  .read<MapProvider>()
                  .addSavedMArker(context.read<DatabaseProvider>().addresses);
              showPlaceInfo(context, argument, myLocation);
            },
            zoomControlsEnabled: false,
            compassEnabled: true,
            mapType: context.watch<MapProvider>().mapType,
            initialCameraPosition: myLocation,
            markers: context.watch<MapProvider>().markers,
            onMapCreated: (GoogleMapController controller) {
              context.read<MapProvider>().controlleer.complete(controller);
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'a',
              key: UniqueKey(),
              onPressed: () {
                context
                    .read<MapProvider>()
                    .followMe(cameraPosition: myLocation);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'b',
              onPressed: () {
                showMapTypeMenu(context);
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.layers_outlined,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
