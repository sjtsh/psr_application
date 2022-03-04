import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/DateRangeManagement.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';

import '../../database.dart';
import '../Entities/OutletOrderItem.dart';

class OrderService {
  Future<void> getOrdersDateRange(
      String startDate, String endDate, BuildContext context) async {
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/getOrdersDateRange"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
        'start_date': startDate,
        "end_date": endDate,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> a = jsonDecode(res.body);
      Map<String, dynamic> ordersMap = a["orders"];
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
      context.read<DateRangeManagement>().requestedOrders = orders;
      return;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }

  Future<bool> insertOrder(Map<String, String> aMap) async {
    Response res = await http.post(
        Uri.parse(
            "https://asia-south1-psr-application-342007.cloudfunctions.net/createOutletOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_id': (meUser?.sessionID ?? ""),
        },
        body: jsonEncode(aMap));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
