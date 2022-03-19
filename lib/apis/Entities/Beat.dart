import 'package:hive/hive.dart';

part 'Beat.g.dart';

@HiveType(typeId: 1)
class HollowBeat extends HiveObject {
  @HiveField(0)
  final int beatPlanID;
  @HiveField(1)
  final int beatID;
  @HiveField(2)
  final bool isDone;
  @HiveField(3)
  final bool inProgress;
  @HiveField(4)
  final String beatName;
  @HiveField(5)
  final String distributorID;
  @HiveField(6)
  final String distributorName;
  @HiveField(7)
  final double distributorLat;
  @HiveField(8)
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
