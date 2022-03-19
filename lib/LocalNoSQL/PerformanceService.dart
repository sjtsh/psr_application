import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/LocalNoSQL/Performance.dart';
import 'package:psr_application/Screens/BeatScreen/components/TodayProgress.dart';
import 'package:psr_application/StateManagement/TodayProgress.dart';

class PerformanceService {
  storePerformance(
    int scheduleVisit,
    int successVisit,
    int productiveVisit,
    int stdQuantitySales,
    double netValueSales,
    int rewardPoints,
    int avgSKU,
    BuildContext context, {
    required int index,
  }) async {
    try {
      Performance t = context.read<TodayProgressState>().performanceBox!.getAt(index)!;
      t.scheduleVisit = scheduleVisit;
      t.successVisit = successVisit;
      t.productiveVisit = productiveVisit;
      t.stdQuantitySales = stdQuantitySales;
      t.netValueSales = netValueSales;
      t.rewardPoints = rewardPoints;
      t.avgSKU = avgSKU;
      t.save();
    } catch (e) {
      Performance p = Performance(
          scheduleVisit: scheduleVisit,
          successVisit: successVisit,
          productiveVisit: productiveVisit,
          stdQuantitySales: stdQuantitySales,
          netValueSales: netValueSales,
          rewardPoints: rewardPoints,
          avgSKU: avgSKU);
      context.read<TodayProgressState>().performanceBox?.add(p);
    }
  }
}
