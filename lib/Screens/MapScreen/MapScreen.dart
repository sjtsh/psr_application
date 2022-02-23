import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Entities/Outlet.dart';

import '../../Entities/outletsEntity.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6539, 85.4617),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          double width = MediaQuery.of(context).size.width;
          return Stack(children: [
            Container(
              height: height,
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                onCameraMove: (CameraPosition a) {},
                markers: List.generate(
                    context.watch<MapManagement>().outletInfo.length,
                    (index) => context
                        .watch<MapManagement>()
                        .outletInfo[index]
                        .marker!).toSet(),
                onMapCreated: (GoogleMapController controller) async {
                 // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 17, tilt: 0, target: LatLng(27.6539, 85.4617))));
                 //  LocationPermission checkPermission = await Geolocator.checkPermission();
                 //  if(checkPermission == LocationPermission.deniedForever){
                 //    LocationPermission permission = await Geolocator.requestPermission();
                 //  }
                  Geolocator.getPositionStream().listen((event) {
                    context.read<MapManagement>().initializeMarkers(
                        LatLng(event.latitude, event.longitude));
                  });
                },
              ),
            ),
            Positioned(
              bottom: 20,
              height: 150,
              width: width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  5,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.bottomCenter,
                        width: 150,
                        child: Builder(builder: (context) {
                          double dis = Geolocator.distanceBetween(
                            context
                                .watch<MapManagement>()
                                .outletInfo[index]
                                .lat,
                            context
                                .watch<MapManagement>()
                                .outletInfo[index]
                                .lng,
                            context
                                .watch<MapManagement>()
                                .userPosition
                                .latitude,
                            context
                                .watch<MapManagement>()
                                .userPosition
                                .longitude,
                          );

                          return Column(
                            children: [
                              Text(context
                                  .watch<MapManagement>()
                                  .outletInfo[index]
                                  .name),
                              Text(dis < 1000
                                  ? dis.toStringAsFixed(2) + " m"
                                  : (dis / 1000).toStringAsFixed(2) + " km"),
                              Text(context
                                  .watch<MapManagement>()
                                  .outletInfo[index]
                                  .id
                                  .toString()),
                            ],
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
