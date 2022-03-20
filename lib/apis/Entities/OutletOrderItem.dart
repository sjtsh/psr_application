import 'package:hive/hive.dart';

part 'OutletOrderItem.g.dart';

@HiveType(typeId: 4)
class OutletOrderItem extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int skuID;
  @HiveField(2)
  final String skuName;
  @HiveField(3)
  final int primaryCount;
  @HiveField(4)
  final String primaryUnit;
  @HiveField(5)
  final String secondaryUnit;
  @HiveField(6)
  final int cf;
  @HiveField(7)
  final double ptr;
  @HiveField(8)
  final double mrp;
  @HiveField(9)
  final bool deactivated;

  OutletOrderItem(this.id, this.skuID, this.skuName, this.primaryCount,
      this.primaryUnit, this.secondaryUnit, this.cf, this.ptr, this.mrp,
      {this.deactivated = false});
}