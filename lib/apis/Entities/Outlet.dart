import 'package:google_maps_flutter/google_maps_flutter.dart';

class Outlet{
  int id;
  int beatID;
  String name;
  String img;
  double lat;
  double lng;
  String mobile;
  String pan;
  bool deactivated;
  Marker ? marker;
  Outlet(this.id, this.beatID, this.name, this.img, this.lat, this.lng, this.mobile, this.pan, this.deactivated);

}