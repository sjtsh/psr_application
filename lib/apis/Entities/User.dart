
import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 8)
class User extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime lastLogin;
  @HiveField(2)
  String name;
  @HiveField(3)
  String reportingManager;
  @HiveField(4)
  bool deactivated;
  @HiveField(5)
  int rewardPoints;
  @HiveField(6)
  String? sessionID;

  User(this.id, this.lastLogin, this.name, this.reportingManager,this.rewardPoints,
      this.deactivated);
}
