import 'package:hive/hive.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

part 'OutletOrder.g.dart';

@HiveType(typeId: 3)
class OutletOrder {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int outletPlanID;
  @HiveField(2)
  final DateTime timeCreated;
  @HiveField(3)
  final String remarks;
  @HiveField(4)
  final bool deactivated;
  @HiveField(5)
  final String beatName;
  @HiveField(6)
  final String outletName;
  @HiveField(7)
  final int outletID;
  @HiveField(8)
  final List<OutletOrderItem> items;

  OutletOrder(
    this.id,
    this.outletPlanID,
    this.timeCreated,
    this.remarks,
    this.beatName,
    this.outletName,
    this.outletID,
    this.items, {
    this.deactivated = false,
  });
}
