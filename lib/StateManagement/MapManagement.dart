import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../apis/Entities/Outlet.dart';

class MapManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<Outlet> _allOutlets = [];
  Outlet? _selectedOutlet;
  GoogleMapController? _controller;

  GoogleMapController? get controller => _controller;

  set controller(GoogleMapController? value) {
    _controller = value;
  }

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

  changeSelectedMarkerOutlet(int index) {
    _controller?.showMarkerInfoWindow(
        _sortedOutlets[index].marker?.markerId ?? const MarkerId("0"));
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17,
        target: LatLng(
          _sortedOutlets[index].lat,
          _sortedOutlets[index].lng,
        ))));
    _selectedOutlet = _sortedOutlets[index];
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17,
        target: LatLng(
          position.latitude,
          position.longitude,
        ))));
  }

  Future<void> openMap() async {
    if (_selectedOutlet != null) {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=${_selectedOutlet!.lat},${_selectedOutlet!.lng}';
      if (await canLaunch(googleUrl) != null) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  void initializeMarkers(LatLng userPosition) {
    _userPosition = userPosition;
    int count = min(5, _allOutlets.length);
    List<Outlet> sortedOutlet = [];
    sortedOutlet.addAll(_allOutlets);
    sortedOutlet.sort((a, b) => Geolocator.distanceBetween(
            userPosition.latitude, userPosition.longitude, a.lat, a.lng)
        .compareTo(Geolocator.distanceBetween(
            userPosition.latitude, userPosition.longitude, b.lat, b.lng)));
    _sortedOutlets = List.generate(
      count,
      (index) {
        Outlet outlet = Outlet(
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
            sortedOutlet[index].deactivated);
        outlet.marker = Marker(
          onTap: () {
            _selectedOutlet = _sortedOutlets[index];
            _scrollController.jumpTo(0 + index * 300);
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
      },
    );
    notifyListeners();
  }
}
