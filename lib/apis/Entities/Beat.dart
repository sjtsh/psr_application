import 'Outlet.dart';

class Beat {
  int id;
  String name;
  String distributorID;
  String userID;
  bool deactivated;
  List<Outlet> outlets = [];

  Beat(this.id, this.name, this.distributorID, this.userID, this.deactivated);
}
