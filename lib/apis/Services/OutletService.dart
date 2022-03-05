import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/database.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../StateManagement/LogInManagement.dart';
import '../../StateManagement/TodayProgress.dart';
import '../Entities/Outlet.dart';

class OutletService {
  Future<List<Outlet>> getOutlets() async {
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/getOutlets"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> parsable = jsonDecode(res.body);
      List<Outlet> beats = parsable
          .map(
            (e) => Outlet(
              e["outlet_plan_id"],
              e["id"],
              e["beat_id"],
              e["name"].toString(),
              e["img"].toString(),
              e["lat"],
              e["lng"],
              e["mobile"].toString(),
              e["pan"].toString(),
              e["owner_name"],
              e["category"],
              e["segmentation"],
              e["deactivated"].toString() == "1",
              e["is_done"].toString() == "1",
            ),
          )
          .toList();
      return beats;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
