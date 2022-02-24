import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:psr_application/Screens/MapScreen/MapHearder.dart';
import 'package:psr_application/Screens/MapScreen/OutletList.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/apis/Entities/Outlet.dart';

import '../../Entities/outletsEntity.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // GoogleMapController? _controller;

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
                  Geolocator.getPositionStream().listen((event) {
                    if (cameraRotate == false) {
                      context.read<MapManagement>().controller = controller;
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
              top: 10,
              left: 12,
              width: width-24,
              child: MapHeader(),
            ),
            Positioned(
              top: 72,
              right: 12,
              child: Container(
                height: 100,
                width: 50,
               decoration:  BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [BoxShadow(
                       offset: Offset(0,2),
                       blurRadius: 2,
                       color: Colors.black.withOpacity(0.1)
                   )]
               ),
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Icon(Icons.info_outline, color: Colors.blue, size: 32,),
                    Expanded(child: Container()),
                    Divider(height: 1, thickness: 1,),
                    Expanded(child: Container()),
                    Icon(Icons.home_filled, color: Colors.blue, size: 32,),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
            context.watch<MapManagement>().allOutlets.length != 0
                ? Positioned(
                    bottom: 10,
                    height: 164,
                    width: width,
                    child: OutletList(),
                  )
                : Positioned(
                    bottom: 0,
                    child: Container(
                      height: 30,
                      color: Colors.white,
                      width: width,
                      child: Center(child: Text("No outlets found")),
                    )),
          ]);
        }),
      ),
    );
  }
}
