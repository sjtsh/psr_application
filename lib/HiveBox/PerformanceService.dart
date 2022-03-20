// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:psr_application/HiveBox/Performance.dart';
//
// import '../StateManagement/AverageVolume.dart';
//
// class PerformanceService {
//   storePerformance(
//     int scheduleVisit,
//     int successVisit,
//     int productiveVisit,
//     int stdQuantitySales,
//     double netValueSales,
//     int rewardPoints,
//     int avgSKU,
//     BuildContext context, {
//     required int index,
//   }) async {
//     try {
//       Performance t = context.read<AverageVolumeState>().performanceBox!.getAt(index)!;
//       t.scheduleVisit = scheduleVisit;
//       t.successVisit = successVisit;
//       t.productiveVisit = productiveVisit;
//       t.stdQuantitySales = stdQuantitySales;
//       t.netValueSales = netValueSales;
//       t.rewardPoints = rewardPoints;
//       t.avgSKU = avgSKU;
//       // t.save();
//     } catch (e) {
//       Performance p = Performance(
//           scheduleVisit: scheduleVisit,
//           successVisit: successVisit,
//           productiveVisit: productiveVisit,
//           stdQuantitySales: stdQuantitySales,
//           netValueSales: netValueSales,
//           rewardPoints: rewardPoints,
//           avgSKU: avgSKU);
//       context.read<AverageVolumeState>().performanceBox?.add(p);
//     }
//   }
// }
