import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/DataManagement.dart';
import 'package:url_launcher/url_launcher.dart';
import '../apis/Entities/Outlet.dart';

class MapManagement with ChangeNotifier, DiagnosticableTreeMixin {
  Outlet? selectedOutlet;
  Outlet? carouselOutlet;
  GoogleMapController? controller;
  List<Outlet> sortedOutlets = [];
  CarouselController carouselController = CarouselController();
  LatLng userPosition = LatLng(0, 0);

  changeSelectedMarkerOutlet(int index) {
    controller?.showMarkerInfoWindow(
        sortedOutlets[index].marker?.markerId ?? const MarkerId("0"));
    controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17,
        target: LatLng(
          sortedOutlets[index].lat,
          sortedOutlets[index].lng,
        ))));
    selectedOutlet = sortedOutlets[index];
  }

  changeSelectedMarkerOutletByCarousel(int index) {
    controller?.showMarkerInfoWindow(
        sortedOutlets[index].marker?.markerId ?? const MarkerId("0"));
    controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17,
        target: LatLng(
          sortedOutlets[index].lat,
          sortedOutlets[index].lng,
        ))));
    selectedOutlet = sortedOutlets[index];
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17,
        target: LatLng(
          position.latitude,
          position.longitude,
        ))));
  }

  Future<void> openMap() async {
    if (selectedOutlet != null) {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=${selectedOutlet!.lat},${selectedOutlet!.lng}';
      if (await canLaunch(googleUrl) != null) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  void initializeMarkers(LatLng userPosition, BuildContext context) {
    this.userPosition = userPosition;
    int count = min(5, context.read<DataManagement>().hiveBox.outlets.length);
    List<Outlet> sortedOutlet = [];
    sortedOutlet.addAll(context.read<DataManagement>().hiveBox.outlets);
    sortedOutlet.sort(
      (a, b) {
        return Geolocator.distanceBetween(
                userPosition.latitude, userPosition.longitude, a.lat, a.lng)
            .compareTo(Geolocator.distanceBetween(
                userPosition.latitude, userPosition.longitude, b.lat, b.lng));
      },
    );
    sortedOutlets = List.generate(
      count,
      (index) {
        Outlet outlet = Outlet(
          sortedOutlet[index].outletPlanId,
          sortedOutlet[index].id,
          sortedOutlet[index].beatID,
          sortedOutlet[index].name,
          sortedOutlet[index].img,
          sortedOutlet[index].lat,
          sortedOutlet[index].lng,
          sortedOutlet[index].mobile,
          sortedOutlet[index].pan,
          sortedOutlet[index].ownerName,
          sortedOutlet[index].category,
          sortedOutlet[index].segmentation,
          sortedOutlet[index].deactivated,
          sortedOutlet[index].isDone,
        );
        outlet.dis = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            sortedOutlet[index].lat,
            sortedOutlet[index].lng);
        outlet.marker = Marker(
          onTap: () {
            selectedOutlet = sortedOutlets[index];
            carouselController.jumpToPage(index);
            //   .animateToPage(index);
          },
          markerId: MarkerId(sortedOutlet[index].name),
          position: LatLng(sortedOutlet[index].lat, sortedOutlet[index].lng),
          icon: selectedOutlet == sortedOutlets[index] ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen) : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(
              title: sortedOutlet[index].name,
              snippet: sortedOutlet[index].id.toString(),
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (_)=> BeatScreen()));
              }),
        );
        return outlet;
      },
    );
    notifyListeners();
  }
}
