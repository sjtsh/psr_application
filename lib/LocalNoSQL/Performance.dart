import 'package:hive/hive.dart';

part 'Performance.g.dart';

@HiveType(typeId: 0)
class Performance extends HiveObject {
  @HiveField(0)
  int scheduleVisit;
  @HiveField(1)
  int successVisit;
  @HiveField(2)
  int productiveVisit;
  @HiveField(3)
  int stdQuantitySales;
  @HiveField(4)
  double netValueSales;
  @HiveField(5)
  int rewardPoints;
  @HiveField(6)
  int avgSKU;

  Performance(
      {required this.scheduleVisit,
      required this.successVisit,
      required this.productiveVisit,
      required this.stdQuantitySales,
      required this.netValueSales,
      required this.rewardPoints,
      required this.avgSKU});
}
