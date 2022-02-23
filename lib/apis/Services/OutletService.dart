import 'package:psr_application/database.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
                e["id"],
                e["beat_id"].toString(),
                e["name"].toString(),
                e["img"].toString(),
                e["lat"],
                e["lng"],
                e["mobile"].toString(),
                e["pan"].toString(),
                e["deactivated"].toString() == "1"),
          )
          .toList();
      return beats;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
