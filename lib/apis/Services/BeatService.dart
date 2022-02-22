import 'package:psr_application/database.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Entities/Beat.dart';

class BeatService {
  Future<List<Beat>> getBeats() async {
    print(meUser?.sessionID ?? "" + " " + (meUser?.id ?? 0).toString());
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/getBeats"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
        'user_id': (meUser?.id ?? 0).toString(),
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> parsable = jsonDecode(res.body);
      List<Beat> beats = parsable
          .map(
            (e) => Beat(e["id"], e["name"], e["distributor_id"],
                e["user_id"], e["deactivated"].toString() == "1"),
          )
          .toList();
      return beats;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
