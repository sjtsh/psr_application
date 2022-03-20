import 'package:hive/hive.dart';

part 'OutletClosedEntity.g.dart';

@HiveType(typeId: 11)
class OutletClosedEntity extends HiveObject{
  @HiveField(0)
  String filePath;
  @HiveField(1)
  String name;
  @HiveField(2)
  String userID;
  @HiveField(3)
  String remarks;
  @HiveField(4)
  int outletPlanID;
  @HiveField(5)
  String timeCreated;

  OutletClosedEntity(this.filePath, this.name, this.userID, this.remarks,
      this.outletPlanID, this.timeCreated);
}
