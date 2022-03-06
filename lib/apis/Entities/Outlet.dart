import 'package:google_maps_flutter/google_maps_flutter.dart';

class Outlet {
  int outletPlanId;
  int id;
  int beatID;
  String name;
  String img;
  double lat;
  double lng;
  String mobile;
  String pan;
  String ownerName;
  String category;
  String segmentation;
  bool deactivated;
  bool isDone;
  Marker? marker;
  double ? dis;

  Outlet(
      this.outletPlanId,
      this.id,
      this.beatID,
      this.name,
      this.img,
      this.lat,
      this.lng,
      this.mobile,
      this.pan,
      this.ownerName,
      this.category,
      this.segmentation,
      this.deactivated,
      this.isDone);
}
