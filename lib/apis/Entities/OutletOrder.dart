import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

class OutletOrder {
  final int id;
  final int outletPlanID;
  final DateTime timeCreated;
  final String remarks;
  final bool deactivated;
  final String beatName;
  final String outletName;
  final int outletID;
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
