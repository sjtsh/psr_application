import 'package:hive/hive.dart';

part 'SKU.g.dart';

@HiveType(typeId: 6)
class SKU {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double mrp;
  @HiveField(3)
  final double ptr;
  @HiveField(4)
  final String img;
  @HiveField(5)
  final String primaryUnit;
  @HiveField(6)
  final String secondaryUnit;
  @HiveField(7)
  final int cf;
  @HiveField(8)
  final bool isTrending;
  @HiveField(9)
  final bool isPromoted;
  @HiveField(10)
  final bool isNew;
  @HiveField(11)
  final int reward;
  @HiveField(12)
  final String erpID;

  SKU(
      this.id,
      this.name,
      this.mrp,
      this.ptr,
      this.img,
      this.primaryUnit,
      this.secondaryUnit,
      this.cf,
      this.isTrending,
      this.isPromoted,
      this.isNew,
      this.reward,
      this.erpID);

  factory SKU.fromJson(int id, Map<String, dynamic> json) {
    return SKU(
      id,
      json["name"],
      double.parse(json["mrp"]),
      double.parse(json["ptr"]),
      json["img"],
      json["primary_unit"],
      json["secondary_unit"],
      json["cf"],
      json["isTrending"].toString() == "1",
      json["isPromoted"].toString() == "1",
      json["isNew"].toString() == "1",
      json["reward"],
      json["erpID"],
    );
  }
}
