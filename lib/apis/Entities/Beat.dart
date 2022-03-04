import 'Outlet.dart';

class HollowBeat {
  final int beatPlanID;
  final int beatID;
  final bool isDone;
  final bool inProgress;
  final String beatName;
  final String distributorID;
  final String distributorName;
  final double distributorLat;
  final double distributorLng;

  HollowBeat(
      this.beatPlanID,
      this.beatID,
      this.isDone,
      this.inProgress,
      this.beatName,
      this.distributorID,
      this.distributorName,
      this.distributorLat,
      this.distributorLng);
}

class Beat {
  int id;
  String name;
  String distributorID;
  String userID;
  bool deactivated;
  List<Outlet> outlets = [];

  Beat(this.id, this.name, this.distributorID, this.userID, this.deactivated);
}
