import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';
import 'package:psr_application/StateManagement/DateRangeManagement.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';

import '../../database.dart';
import '../Entities/OutletOrderItem.dart';
import '../Entities/SKU.dart';
import '../Entities/SubGroup.dart';

class OrderService {
  Future<void> getPerformanceDateRange(
      String startDate, String endDate, BuildContext context) async {
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/getProgressDateRange"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
        'start_date': startDate,
        "end_date": endDate,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> a = jsonDecode(res.body);
      // context.read<AverageVolumeState>().customSaleVolume  = double.parse(a["sales"].toString());
      // context.read<AverageVolumeState>().customSKUVariance  = int.parse(a["sku"].toString());
      return;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }

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

  Future<bool> insertOrder(
      Map<SubGroup, Map<SKU, int>> aMap,
      String remarks,
      int outletPlanID,
      String signatureImgUrl,
      String ownerImgUrl,
      Map<SubGroup, String> competitiveExistingStock,
      Map<SubGroup, Map<String, String>> ownExistingStock,
      // the value for a subgroup to have two keys first one should be stock_count and other should be img url
      Map<SubGroup, String> noOrderReasons) async {
    Map<String, dynamic> bodyMap = {};
    for (var element1 in aMap.values) {
      for (var element in element1.entries) {
        if (!bodyMap.containsKey("items")) {
          bodyMap["items"] = {};
        }
        bodyMap["items"][element.key.id.toString()] = element.value.toString();
      }
    }

    Map resultCompetitiveExistingStock = {};
    for (var i in competitiveExistingStock.keys) {
      resultCompetitiveExistingStock[i.name] = competitiveExistingStock[i];
    }
    Map resultNoOrderReasons = {};
    for (var i in noOrderReasons.keys) {
      resultNoOrderReasons[i.name] = noOrderReasons[i];
    }
    Map resultownExistingStockStock = {};
    for (var i in ownExistingStock.keys) {
      resultownExistingStockStock[i.name] = ownExistingStock[i];
    }
    bodyMap["outlet_plan_id"] = outletPlanID.toString();
    bodyMap["remarks"] = remarks;
    bodyMap["signature_img_url"] = signatureImgUrl;
    bodyMap["owner_img_url"] = ownerImgUrl;
    bodyMap["owner_img_url"] = resultCompetitiveExistingStock;
    bodyMap["own_existing_stock"] = resultownExistingStockStock;
    bodyMap["no_order_reasons"] = resultNoOrderReasons;
    bodyMap["time_created"] = NepaliDateTime.now().toString().substring(0, 19);


    Response res = await http.post(
        Uri.parse(
            "https://asia-south1-psr-application-342007.cloudfunctions.net/createOutletOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_id': (meUser?.sessionID ?? ""),
        },
        body: jsonEncode(bodyMap));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }

  Future<bool> updateOrder(
      Map<SubGroup, Map<SKU, int>> aMap, String remarks, int orderID) async {
    Map<String, dynamic> bodyMap = {};
    for (var element1 in aMap.values) {
      for (var element in element1.entries) {
        if (!bodyMap.containsKey("items")) {
          bodyMap["items"] = {};
        }
        bodyMap["items"][element.key.id.toString()] = element.value.toString();
      }
    }
    bodyMap["order_id"] = orderID.toString();
    bodyMap["remarks"] = remarks +
        "updated at" +
        NepaliDateTime.now().toString().substring(0, 19);

    Response res = await http.put(
        Uri.parse(
            "https://asia-south1-psr-application-342007.cloudfunctions.net/updateOutletOrder"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'session_id': (meUser?.sessionID ?? ""),
        },
        body: jsonEncode(bodyMap));
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
