import 'package:hive/hive.dart';
import 'package:psr_application/apis/Entities/Performance.dart';
import 'package:psr_application/apis/Entities/Outlet.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../apis/Entities/Beat.dart';
import '../apis/Entities/User.dart';

part 'HiveBox.g.dart';

@HiveType(typeId: 0)
class HiveBox extends HiveObject {
  @HiveField(0)
  List<Performance> performances;
  @HiveField(1)
  List<OutletOrder> outletOrders;
  @HiveField(2)
  List<Outlet> outlets;
  @HiveField(3)
  List<SubGroup> subgroups;
  @HiveField(4)
  List<HollowBeat> beats;
  @HiveField(5)
  User user;

  HiveBox({
    required this.performances,
    required this.outletOrders,
    required this.outlets,
    required this.subgroups,
    required this.beats,
    required this.user,
  });
}
