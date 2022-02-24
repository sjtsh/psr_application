import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/BeatManagement.dart';
import 'package:psr_application/apis/Services/OutletService.dart';

import '../Entities/outletsEntity.dart';
import '../apis/Entities/Outlet.dart';

class MapManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<Marker> _markerss = [];
  final List<Outlet> _outletInfo = [
    Outlet(1, 1, "AB store", "", 27.725643911262072, 85.34449226903803,
        "9818173521", "012345678", false),
    Outlet(2, 1, "helo", "", 27.726327916301226, 85.34333387273254,
        "9818173521", "012345678", false),
    Outlet(3, 1, "Daya", "", 27.725439096335705, 85.34330728622666,
        "9818173521", "012345678", false),
    Outlet(4, 1, "mini store", "", 27.72552067254513, 85.3419713106457,
        "9818173521", "012345678", false),
    Outlet(1, 1, "saya", "", 27.726631828527488, 85.3409735161877,
        "9818173521", "012345678", false),
    Outlet(2, 1, "maya", "", 27.726175975235538, 85.34234680710989,
        "9818173521", "012345678", false),
    Outlet(3, 1, "hori", "", 27.724865386402772, 85.34114517755299,
        "9818173521", "012345678", false),
    Outlet(4, 1, "dori", "", 27.724979351274555, 85.34166016164879,
        "9818173521", "012345678", false),
    Outlet(4, 1, "dori", "",  27.7257, 85.3433,
        "9818173521", "012345678", false),
  ];


  List<Outlet> a = [];
  ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  List<Marker> get markerss => _markerss;
  LatLng _userPosition = LatLng(0, 0);

  List<Outlet> get outletInfo => a;

  LatLng get userPosition => this._userPosition;
  List _dis = [];

  get distance => _dis;


  void initializeMarkers(LatLng userPosition) {
    this._userPosition = userPosition;
    int count = min(5, _outletInfo.length);
    List<Outlet> sortedOutlet = [];
    sortedOutlet.addAll(_outletInfo);
    sortedOutlet.sort((a, b) => Geolocator.distanceBetween(
            userPosition.latitude, userPosition.longitude, a.lat, a.lng)
        .compareTo(Geolocator.distanceBetween(
            userPosition.latitude, userPosition.longitude, b.lat, b.lng)));
    a = List.generate(count, (index) {
      Outlet outlet = Outlet(
          sortedOutlet[index].id,
          sortedOutlet[index].beatID,
          sortedOutlet[index].name,
          sortedOutlet[index].img,
          sortedOutlet[index].lat,
          sortedOutlet[index].lng,
          sortedOutlet[index].mobile,
          sortedOutlet[index].pan,
          sortedOutlet[index].deactivated);
      outlet.marker = Marker(
        onTap: (){
          _scrollController.jumpTo(0 + index * 156);
        },
        markerId: MarkerId(sortedOutlet[index].name),
        position: LatLng(sortedOutlet[index].lat, sortedOutlet[index].lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
            title: sortedOutlet[index].name,
            snippet: sortedOutlet[index].id.toString(),
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (_)=> BeatScreen()));
            }),
      );
      return outlet;
    });
    notifyListeners();
  }
}
