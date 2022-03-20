import 'package:hive/hive.dart';

import '../Entities/SKU.dart';
import '../Entities/SubGroup.dart';

part 'OutletOrderEntity.g.dart';

@HiveType(typeId: 9)
class OutletOrderEntity extends HiveObject{
  @HiveField(0)
  Map<SubGroup, Map<SKU, int>> aMap;
  @HiveField(1)
  String remarks;
  @HiveField(2)
  int outletPlanID;
  @HiveField(3)
  String signatureImgUrl;
  @HiveField(4)
  String ownerImgUrl;
  @HiveField(5)
  Map<SubGroup, String> competitiveExistingStock;
  @HiveField(6)
  Map<SubGroup, Map<String, String>> ownExistingStock;
  @HiveField(7)
  Map<SubGroup, String> noOrderReasons;

  OutletOrderEntity(
      this.aMap,
      this.remarks,
      this.outletPlanID,
      this.signatureImgUrl,
      this.ownerImgUrl,
      this.competitiveExistingStock,
      this.ownExistingStock,
      this.noOrderReasons);
}
