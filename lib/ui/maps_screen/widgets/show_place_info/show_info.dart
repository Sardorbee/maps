import 'package:dio_example/data/models/user_address.dart';
import 'package:dio_example/services/provider/db_provider.dart';
import 'package:dio_example/services/provider/map_provider.dart';
import 'package:dio_example/ui/maps_screen/widgets/show_place_info/custom_button.dart';
import 'package:dio_example/ui/maps_screen/widgets/show_place_info/kind_selector.dart';
import 'package:dio_example/ui/maps_screen/widgets/show_place_info/lang_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void showPlaceInfo(
    BuildContext context, LatLng location, CameraPosition mylocation) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      double responsiveHeight = MediaQuery.of(context).size.height;
      double responsiveWidth = MediaQuery.of(context).size.width;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: responsiveHeight * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<MapProvider>(
                builder: (context, x, child) {
                  x.getAddressByLatLong(latLng: location);
                  return Text(x.address, style: const TextStyle(fontSize: 18));
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: responsiveWidth * 0.03,
                  ),
                  const Row(
                    children: [
                      Text("Language:  "),
                      LangSelector(),
                    ],
                  ),
                  SizedBox(
                    width: responsiveWidth * 0.01,
                  ),
                  const Row(
                    children: [
                      Text("Kind:  "),
                      KindSelector(),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('Lat: ${location.latitude}'.substring(0, 12)),
              Text('Long: ${location.longitude}'.substring(0, 12)),
              SizedBox(
                height: responsiveHeight * 0.01,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Directions",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: responsiveWidth * 0.01,
                        ),
                        Visibility(
                          visible: !context.read<MapProvider>().isStartedRoute,
                          child: MyButton(
                            color: Colors.blue,
                            icon: Icons.keyboard_double_arrow_up_sharp,
                            text: "Start",
                            onPressed: () {
                              context.read<MapProvider>().addRouteStartMarker(
                                  mylocation.target.latitude,
                                  mylocation.target.longitude);
                              context.read<MapProvider>().addRouteFinishMarker(
                                  location.latitude, location.longitude);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Visibility(
                          visible: context.read<MapProvider>().isStartedRoute,
                          child: MyButton(
                            color: Colors.blue,
                            icon: Icons.clear,
                            text: "Stop",
                            onPressed: () {
                              context.read<MapProvider>().clearMarkers();
                              context.read<MapProvider>().updateIsStarted();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: responsiveWidth * 0.01,
                        ),
                        MyButton(
                          color: Colors.blue,
                          icon: Icons.bookmark_border,
                          text: "Save",
                          onPressed: () {
                            context.read<DatabaseProvider>().insertAddress(
                                  UserAddress(
                                    lat: location.latitude,
                                    long: location.longitude,
                                    address:
                                        context.read<MapProvider>().address,
                                    createdAt: DateTime.now().toString(),
                                  ),
                                );
                            context.read<MapProvider>().addSavedMArker(
                                context.read<DatabaseProvider>().addresses);
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: responsiveWidth * 0.01,
                        ),
                        MyButton(
                          color: Colors.blue,
                          icon: Icons.share,
                          text: "Share",
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: responsiveWidth * 0.01,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
