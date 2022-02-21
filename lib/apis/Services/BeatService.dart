import 'package:psr_application/database.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Entities/Beat.dart';

class BeatService {
  Future<List<Beat>> getBeats() async {
    Response res = await http.get(
      Uri.parse("uri"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
      },
    );
    if (res.statusCode == 200) {
      List<Map<String, dynamic>> parsable = jsonDecode(res.body);
      List<Beat> beats = parsable
          .map(
            (e) => Beat(int.parse(e["id"]), e["name"], e["distributorID"],
                e["userID"], e["deactivated"] == "true"),
          )
          .toList();
      return beats;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
