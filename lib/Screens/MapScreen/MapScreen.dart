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
import 'package:psr_application/StateManagement/ShopClosedController.dart';
import 'package:psr_application/apis/Entities/Outlet.dart';

import '../../StateManagement/DataManagement.dart';

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
              polylines: {
                Polyline(
                    polylineId: PolylineId("polylineId"),
                    points: context.watch<ShopClosedController>().latlngs)
              },
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
                  try{
                    context.read<MapManagement>().initializeMarkers(
                        LatLng(event.latitude, event.longitude), context);
                  }catch(e){

                  }
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
            context.read<DataManagement>().hiveBox.outlets.isNotEmpty
                ? Positioned(
                    bottom: 0,
                    height: 300,
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
          ]),
        ),
      ),
    );
  }
}
