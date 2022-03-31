import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/HiveBox/LocalToInsert.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';
import 'package:psr_application/StateManagement/DateRangeManagement.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import 'package:psr_application/apis/LocalToInsert/OutletOrderEntity.dart';

import '../../StateManagement/DataManagement.dart';
import '../../StateManagement/SignatureManagement.dart';
import '../../database.dart';
import '../Entities/OutletOrderItem.dart';
import '../Entities/SKU.dart';
import '../Entities/SubGroup.dart';
import 'ShopClosed.dart';

class OrderService {
  Future<bool> insertOrder(
      Map<SubGroup, Map<SKU, int>> aMap,
      String remarks,
      int outletPlanID,
      String signaturePicture,
      String ownerPicture,
      Map<SubGroup, String> competitiveExistingStock,
      Map<SubGroup, Map<String, String>> ownExistingStock,
      // the value for a subgroup to have two keys first one should be stock_count and other should be img url
      Map<SubGroup, String> noOrderReasons,
      BuildContext context) async {
    bool connection = await checkInternet();
    if (connection) {
      String ownerImgUrl = await OutletClosedService().uploadFile(
          file: File(ownerPicture),
          name: "owner/${NepaliDateTime.now()}",
          userID: context.read<DataManagement>().hiveBox.user.id);
      context.read<SignatureManagement>().incrementValue(20);
      String signatureImgUrl = await OutletClosedService().uploadFile(
          file: File(signaturePicture),
          name: "signature/${NepaliDateTime.now()}",
          userID: context.read<DataManagement>().hiveBox.user.id);
      context.read<SignatureManagement>().incrementValue(40);
      Map<String, dynamic> bodyMap = {};
      for (var element1 in aMap.values) {
        for (var element in element1.entries) {
          if (!bodyMap.containsKey("items")) {
            bodyMap["items"] = {};
          }
          bodyMap["items"][element.key.id.toString()] =
              element.value.toString();
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
      bodyMap["signature_img"] = signatureImgUrl;
      bodyMap["owner_img"] = ownerImgUrl;
      bodyMap["competitive_existing_stocks"] = resultCompetitiveExistingStock;

      List keys = resultownExistingStockStock.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        String path = resultownExistingStockStock[keys[i]]["img"];
        String ownerUrl = await OutletClosedService().uploadFile(
            file: File(path),
            name: "existing_stock/${NepaliDateTime.now()}",
            userID: meUser!.id);
        resultownExistingStockStock[keys[i]]["img"] = ownerUrl;
      }

      bodyMap["own_existing_stocks"] = resultownExistingStockStock;
      bodyMap["no_order_reasons"] = resultNoOrderReasons;
      bodyMap["time_created"] =
          NepaliDateTime.now().toString().substring(0, 19);
      context.read<SignatureManagement>().incrementValue(60);
      print(bodyMap);
      Response res = await http.post(
          Uri.parse(
              "https://asia-south1-psr-application-342007.cloudfunctions.net/createOutletOrder"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'session_id': (meUser?.sessionID ?? ""),
          },
          body: jsonEncode(bodyMap));
      context.read<SignatureManagement>().incrementValue(90);
      if (res.statusCode == 200) {
        context.read<DataManagement>().syncOutletOrder(OutletOrderEntity(
            aMap,
            remarks,
            outletPlanID,
            signaturePicture,
            ownerPicture,
            competitiveExistingStock,
            ownExistingStock,
            noOrderReasons));
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        return true;
      } else {
        throw "Status code is ${res.statusCode}";
      }
    } else {
      await context.read<DataManagement>().insertOutletOrder(OutletOrderEntity(
          aMap,
          remarks,
          outletPlanID,
          signaturePicture,
          ownerPicture,
          competitiveExistingStock,
          ownExistingStock,
          noOrderReasons));
      return true;
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
