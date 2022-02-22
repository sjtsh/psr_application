import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:psr_application/database.dart';

import '../Entities/User.dart';

class UserService {
  Future<User> Login(String username, String password) async {
    Response res = await http.get(
      Uri.parse("https://asia-south1-psr-application-342007.cloudfunctions.net/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'username': username,
        'password': password,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> parsable = jsonDecode(res.body)[0];
      User user = User(
          parsable["id"],
          DateTime.fromMillisecondsSinceEpoch(parsable["last_login"]),
          parsable["name"],
          parsable["reportingManager_id"],
          parsable["deactivated"].toString() == "1");
      user.sessionID = parsable["session_id"];
      meUser = user;
      return user;
    } else {
      throw "Status code is not 200";
    }
  }
}
