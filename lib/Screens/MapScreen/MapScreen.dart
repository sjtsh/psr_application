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
  final Function page;

  MapScreen(this.page);

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(27.6539, 85.4617),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
          body: Stack(children: [
            GoogleMap(
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
                            target: LatLng(event.latitude, event.longitude))));
                    cameraRotate = true;
                  }
                  context.read<MapManagement>().initializeMarkers(
                      LatLng(event.latitude, event.longitude));
                });
              },
            ),
            Positioned(
              top: 12,
              left: 12,
              width: width - 24,
              child: MapHeader(page),
            ),
            // Map side UI
            const MapSideUI(),

            //List of outlets UI
            context.watch<MapManagement>().allOutlets.isNotEmpty
                ? Positioned(
                    bottom: 46,
                    height: 210,
                    width: width,
                    child: const OutletList(),
                  )
                : Positioned(
                    bottom: 46,
                    child: Container(
                      height: 30,
                      color: Colors.white,
                      width: width,
                      child: const Center(child: Text("No outlets found")),
                    )),
            Positioned(
              bottom: 0,
              height: 50,
              width: width,
              child: GestureDetector(
                onTap: () {
                  context.read<MapManagement>().carouselController.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16)),
                          child: MaterialButton(
                              onPressed: () {
                                context
                                    .read<MapManagement>()
                                    .carouselController
                                    .previousPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                              },
                              child: Text(
                                "PREVIOUS",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16)),
                          child: MaterialButton(
                              elevation: 0,
                              onPressed: () {
                                context
                                    .read<MapManagement>()
                                    .carouselController
                                    .nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                              },
                              child: Text(
                                "NEXT",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
