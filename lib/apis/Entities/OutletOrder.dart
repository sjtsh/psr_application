import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

class OutletOrder {
  final int id;
  final int outletPlanID;
  final DateTime timeCreated;
  final String remarks;
  final bool deactivated;
  final List<OutletOrderItem> items;

  OutletOrder(
    this.id,
    this.outletPlanID,
    this.timeCreated,
    this.remarks,
    this.items, {
    this.deactivated = false,
  });
}
