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
  List<Outlet> _allOutlets = [];

  List<Outlet> get allOutlets => _allOutlets;

  set allOutlets(List<Outlet> value) {
    _allOutlets = value;
  }

  List<Outlet> _sortedOutlets = [];
  List<Outlet> get sortedOutlets => _sortedOutlets;

  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  LatLng _userPosition = LatLng(0, 0);


  LatLng get userPosition => this._userPosition;
  List _dis = [];

  get distance => _dis;

  void initializeMarkers(LatLng userPosition) {
    this._userPosition = userPosition;
    int count = min(5, _allOutlets.length);
    List<Outlet> sortedOutlet = [];
    sortedOutlet.addAll(_allOutlets);
    sortedOutlet.sort((a, b) => Geolocator.distanceBetween(
            userPosition.latitude, userPosition.longitude, a.lat, a.lng)
        .compareTo(Geolocator.distanceBetween(
            userPosition.latitude, userPosition.longitude, b.lat, b.lng)));
    _sortedOutlets = List.generate(count, (index) {
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
        onTap: () {
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
