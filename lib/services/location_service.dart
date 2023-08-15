import 'package:dio_example/services/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

initLocationService(BuildContext context) async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();

  debugPrint(
      "LONGITUDE:${locationData.longitude} AND LAT:${locationData.longitude}");

  location.enableBackgroundMode(enable: true);

  location.onLocationChanged.listen((LocationData newLocation) {
    if (context.read<MapProvider>().isStartedRoute == true) {
      // context
      //     .read<MapProvider>()
      //     .addRouteStartMarker(newLocation.latitude!, newLocation.longitude!);
      context.read<MapProvider>().addStreamMarker(newLocation);
    }

    debugPrint("LONGITUDE:${newLocation.longitude}");
  });
}
