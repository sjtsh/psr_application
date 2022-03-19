import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/LocalNoSQL/PerformanceService.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:psr_application/StateManagement/TodayProgress.dart';
import 'package:psr_application/apis/Entities/Beat.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

import '../../LocalNoSQL/Performance.dart';
import '../../StateManagement/BeatManagement.dart';
import '../../StateManagement/MapManagement.dart';
import '../../database.dart';
import '../Entities/OutletOrder.dart';

class TourPlanService {
  Future<bool> getTourPlan(BuildContext context) async {
    Response response = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/getTourPlan"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> aMap = jsonDecode(response.body);
      Map<String, dynamic> beatPlanMap = aMap["beat_plans"];
      Map<String, dynamic> ordersMap = aMap["orders"];
      List<OutletOrder> orders = ordersMap.keys.map((e) {
        Map<String, dynamic> items = ordersMap[e]["items"];
        return OutletOrder(
          int.parse(e.toString()),
          ordersMap[e]["outlet_plan_id"],
          DateTime.parse(ordersMap[e]["time_created"]),
          ordersMap[e]["remarks"],
          ordersMap[e]["beat_name"],
          ordersMap[e]["outlet_name"],
          int.parse(ordersMap[e]["outlet_id"].toString()),
          items.keys
              .map((f) => OutletOrderItem(
                  int.parse(f.toString()),
                  items[f]["sku_id"],
                  items[f]["name"],
                  items[f]["primary_count"],
                  items[f]["primary_unit"],
                  items[f]["secondary_unit"],
                  items[f]["cf"],
                  double.parse(items[f]["ptr"].toString()),
                  double.parse(items[f]["mrp"].toString())))
              .toList(),
        );
      }).toList();
      List<HollowBeat> beats = beatPlanMap.keys
          .map((e) => HollowBeat(
              beatPlanMap[e]["id"],
              beatPlanMap[e]["beat_id"],
              beatPlanMap[e]["is_done"] == 1,
              beatPlanMap[e]["in_progress"] == 1,
              beatPlanMap[e]["beat_name"],
              beatPlanMap[e]["distributor_id"],
              beatPlanMap[e]["distributor_name"],
              double.parse(beatPlanMap[e]["distributor_lat"].toString()),
              double.parse(beatPlanMap[e]["distributor_lng"].toString())))
          .toList();
      ["daily", "weekly", "monthly"].asMap().entries.forEach((element) async {
        await context.read<TodayProgressState>().performanceBox?.put(
            element.key,
            Performance(
                scheduleVisit: int.parse(aMap[element.value]["total"].toString()),
                successVisit: int.parse(aMap[element.value]["visited"].toString()),
                productiveVisit:
                int.parse(aMap[element.value]["productive"].toString()),
                stdQuantitySales: int.parse(aMap[element.value]["std"].toString()),
                netValueSales:
                double.parse(aMap[element.value]["sales"].toString()) + 0.0,
                rewardPoints: int.parse(aMap[element.value]["reward"].toString()),
                avgSKU: int.parse(aMap[element.value]["sku"].toString())));
      });
      context.read<BeatManagement>().beats = beats;
      context.read<BeatManagement>().outletOrders = orders;
      context.read<TodayProgressState>().inProgressBeat =
          beats.firstWhere((element) => element.inProgress);
      return true;
    }
    throw "couldnt complete";
  }
}
