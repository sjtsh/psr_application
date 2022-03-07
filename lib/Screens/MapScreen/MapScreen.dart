import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:psr_application/Screens/MapScreen/MapHearder.dart';
import 'package:psr_application/Screens/MapScreen/MapSideUI.dart';
import 'package:psr_application/Screens/MapScreen/OutletList.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Entities/Outlet.dart';

class MapScreen extends StatelessWidget {

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(27.6539, 85.4617),
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
   child: Scaffold(
      body: Builder(builder: (context) {
        double width = MediaQuery.of(context).size.width;
        return Stack(children: [
          Container(
            height: height,
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              onCameraMove: (CameraPosition a) {},
              markers: List.generate(
                  context.watch<MapManagement>().sortedOutlets.length,
                  (index) => context
                      .watch<MapManagement>()
                      .sortedOutlets[index]
                      .marker!).toSet(),
              onMapCreated: (GoogleMapController controller) async {
                bool cameraRotate = false;
                context.read<MapManagement>().controller = controller;
                Geolocator.getPositionStream().listen((event) {
                  if (cameraRotate == false) {
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            zoom: 17,
                            tilt: 0,
                            target:
                                LatLng(event.latitude, event.longitude))));
                    cameraRotate = true;
                  }
                  context.read<MapManagement>().initializeMarkers(
                      LatLng(event.latitude, event.longitude));
                });
              },
            ),
          ),
          Positioned(
            top: height*0.05,
            left: 12,
            width: width-24,
            child: MapHeader(),
          ),
         // Map side UI
         const MapSideUI(),
          //List of outlets UI
          context.watch<MapManagement>().allOutlets.isNotEmpty
              ? Positioned(
                  bottom: 10,
                  height: 210,
                  width: width,
                  child: const OutletList(),
                )
              : Positioned(
                  bottom: 0,
                  child: Container(
                    height: 30,
                    color: Colors.white,
                    width: width,
                    child: const Center(child: Text("No outlets found")),
                  )),
        ]);
      }),)
    );
  }
}


