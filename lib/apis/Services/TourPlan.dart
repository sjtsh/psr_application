import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:psr_application/StateManagement/TodayProgress.dart';
import 'package:psr_application/apis/Entities/Beat.dart';
import 'package:psr_application/apis/Entities/OutletOrderItem.dart';

import '../../StateManagement/BeatManagement.dart';
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
      context.read<TodayProgressState>().uniqueSKU =
          double.parse(aMap["daily"]["sku"].toString()) + 0.0;
      context.read<AverageVolumeState>().monthlySKUVariance =
          double.parse(aMap["monthly"]["sku"].toString()) + 0.0;
      context.read<TodayProgressState>().netValueSales =
          double.parse(aMap["daily"]["sales"].toString()) + 0.0;
      context.read<AverageVolumeState>().monthlySaleVolume =
          double.parse(aMap["monthly"]["sales"].toString()) + 0.0;
      context.read<AverageVolumeState>().weeklySaleVolume =
          double.parse(aMap["weekly"]["sales"].toString()) + 0.0;
      context.read<AverageVolumeState>().weeklySKUVariance =
          double.parse(aMap["weekly"]["sku"].toString()) + 0.0;
      int stdQuantity = 0;
      for (var element in orders) {
        for (var element in element.items) {
          stdQuantity += element.primaryCount;
        }
      }
      context.read<TodayProgressState>().stdQuantitySales = stdQuantity;
      context.read<TodayProgressState>().successVisitText = orders.length;
      context.read<BeatManagement>().beats =beats;
      context.read<BeatManagement>().outletOrders = orders;
      context.read<TodayProgressState>().scheduleVisit =
          context.read<LogInManagement>().allOutletsLocal.length;
      context.read<TodayProgressState>().visitText = context
          .read<LogInManagement>()
          .allOutletsLocal
          .where((element) => element.isDone)
          .length;
      return true;
    }
    throw "couldnt complete";
  }
}
