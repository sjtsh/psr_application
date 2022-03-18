import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TodayPerformance extends HiveObject {
  @HiveField(0)
  int scheduleVisit;

  @HiveField(1)
  int successVisit;

  @HiveField(2)
  int productiveVisits;

  @HiveField(3)
  int stdQuantitySales;

  @HiveField(4)
  int netValueSales;

  @HiveField(5)
  int avgSKU;

  TodayPerformance(
      {required this.scheduleVisit,
      required this.successVisit,
      required this.productiveVisits,
      required this.stdQuantitySales,
      required this.netValueSales,
      required this.avgSKU});
}
