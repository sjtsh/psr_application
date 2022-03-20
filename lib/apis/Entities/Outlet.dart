import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'Outlet.g.dart';

@HiveType(typeId: 2)
class Outlet extends HiveObject {
  @HiveField(0)
  int outletPlanId;
  @HiveField(1)
  int id;
  @HiveField(2)
  int beatID;
  @HiveField(3)
  String name;
  @HiveField(4)
  String img;
  @HiveField(5)
  double lat;
  @HiveField(6)
  double lng;
  @HiveField(7)
  String mobile;
  @HiveField(8)
  String pan;
  @HiveField(9)
  String ownerName;
  @HiveField(10)
  String category;
  @HiveField(11)
  String segmentation;
  @HiveField(12)
  bool deactivated;
  @HiveField(13)
  bool isDone;
  @HiveField(14)
  Marker? marker;
  @HiveField(15)
  double? dis;

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
