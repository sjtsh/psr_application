import 'package:hive/hive.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

part 'OutletOrder.g.dart';

@HiveType(typeId: 1)
class OutletOrderLocal extends HiveObject {
  @HiveField(0)
  final int outletPlanID;
  @HiveField(1)
  final DateTime timeCreated;
  @HiveField(2)
  final String remarks;
  @HiveField(3)
  final String beatName;
  @HiveField(4)
  final String outletName;
  @HiveField(5)
  final int outletID;
  @HiveField(6)
  final List<OutletOrderItem> items;

  OutletOrderLocal(
    this.outletPlanID,
    this.timeCreated,
    this.remarks,
    this.beatName,
    this.outletName,
    this.outletID,
    this.items,
  );
}
