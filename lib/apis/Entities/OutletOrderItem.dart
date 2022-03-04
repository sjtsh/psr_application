class OutletOrderItem {
  final int id;
  final int skuID;
  final String skuName;
  final int primaryCount;
  final String primaryUnit;
  final String secondaryUnit;
  final int cf;
  final double ptr;
  final double mrp;
  final bool deactivated;

  OutletOrderItem(this.id, this.skuID, this.skuName, this.primaryCount, this.primaryUnit, this.secondaryUnit, this.cf, this.ptr, this.mrp,
      {this.deactivated = false});
}

// {
// "outletID":"<outletID>",
// "remarks":"<remarks>"
// "items": {
//     "<skuID>" : "<primary count>",
//     "<skuID>" : "<primary count>"
//   }
// }