class OutletOrder{
  int id;
  String userID;
  int outletID;
  DateTime timeCreated;
  String remarks;
  bool deactivated;
  OutletOrder(this.id, this.userID, this.outletID, this.timeCreated, this.remarks, this.deactivated);
}