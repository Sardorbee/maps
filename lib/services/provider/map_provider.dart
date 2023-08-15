import 'dart:async';
import 'dart:typed_data';

import 'package:dio_example/data/models/universal_data.dart';
import 'package:dio_example/data/models/user_address.dart';
import 'package:dio_example/data/network/api.dart';
import 'package:dio_example/utils/constants/constants.dart';
import 'package:dio_example/utils/utility_fns.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapProvider with ChangeNotifier {
  MapProvider({required this.apiService, required BuildContext context});

  final ApiService apiService;

  String address = '';
  String kind = "house";
  String lang = "uz_UZ";
  Set<Marker> markers = {};
  bool isStartedRoute = false;

  double latt = 0;
  double long = 0;
  MapType mapType = MapType.normal;
  final Completer<GoogleMapController> controlleer =
      Completer<GoogleMapController>();
  String dropdownValue = kindList.first;
  String newLAng = langList.first;

  Future<void> followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await controlleer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    notifyListeners();
  }

  setMapType(MapType maapType) {
    mapType = maapType;
    notifyListeners();
  }

  getAddressByLatLong({required LatLng latLng}) async {
    UniversalData universalData = await apiService.getAddress(
      latLng: latLng,
      kind: kind,
      lang: lang,
    );

    if (universalData.error.isEmpty) {
      address = universalData.data as String;
    } else {
      debugPrint("ERROR:${universalData.error}");
    }
    notifyListeners();
  }

  clearMarkers() {
    markers.clear();
    notifyListeners();
  }

  addSavedMArker(List<UserAddress>? addresses) {
    if (addresses!.isNotEmpty) {
      for (var address in addresses) {
        final customIcon = BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue, // Adjust the color as needed
        );

        markers.add(
          Marker(
            icon: customIcon,
            markerId: MarkerId(address.id.toString()),
            position: LatLng(address.lat, address.long),
            infoWindow: InfoWindow(
              title: address.address,
              snippet: address.createdAt,
            ),
          ),
        );
      }
    }
    notifyListeners();
  }

  updateLatLngAndAddMArker(
    LatLng argument,
  ) {
    latt = argument.latitude;
    long = argument.longitude;

    markers.add(
      Marker(
        markerId: const MarkerId('myMarker'),
        position: LatLng(latt, long),
        infoWindow: InfoWindow(title: address),
      ),
    );
    notifyListeners();
  }

  addStreamMarker(
    LocationData location,
  ) async {
    Uint8List uint8list = await getBytesFromAsset("assets/dot.png", 50);

    latt = location.latitude!;
    long = location.longitude!;

    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(uint8list),
        markerId: MarkerId(location.time!.toString()),
        position: LatLng(latt, long),
        infoWindow: InfoWindow(title: location.satelliteNumber.toString()),
      ),
    );
    notifyListeners();
  }

  addRouteStartMarker(
    double lat,
    double longgg,
  ) async {
    Uint8List uint8list = await getBytesFromAsset("assets/start.png", 150);

    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(uint8list),

        markerId: MarkerId(DateTime.now().toString()),
        position: LatLng(lat, longgg),
        infoWindow: const InfoWindow(title: 'Start'),
      ),
    );
    isStartedRoute = true;
    notifyListeners();
  }

  updateIsStarted() {
    isStartedRoute = !isStartedRoute;
    notifyListeners();
  }

  addRouteFinishMarker(
    double lat,
    double longgg,
  ) async {
    Uint8List uint8list = await getBytesFromAsset("assets/finish.png", 150);

    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(uint8list),

        markerId: MarkerId(DateTime.now().toString()),
        position: LatLng(lat, longgg),
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    );
    isStartedRoute = true;
    notifyListeners();
  }

  updateDropdownValue(value) {
    dropdownValue = value;
    notifyListeners();
  }

  updateLangvalue(value) {
    newLAng = value;
    notifyListeners();
  }

  void updateKind() {
    kind = dropdownValue;
  }

  void updateLang() {
    lang = newLAng;
  }

  bool canSaveAddress() {
    if (address.isEmpty) return false;
    if (address == 'Aniqlanmagan Hudud') return false;

    return true;
  }
}
