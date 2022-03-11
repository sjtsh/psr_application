import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:psr_application/database.dart';

import '../Entities/User.dart';

class UserService {
  Future<User> Login(String username, String password) async {
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'username': username,
        'password': password,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> parsable = jsonDecode(res.body)[0];
      try {
        User user = User(
            parsable["id"],
            DateTime.fromMillisecondsSinceEpoch(parsable["last_login"]),
            parsable["name"],
            parsable["reportingManager_id"],
            parsable["reward_points"],
            parsable["deactivated"].toString() == "1");
        user.sessionID = parsable["session_id"];
        meUser = user;
        print("got user");
        return user;
      } catch (e) {
        throw "Password incorrect";
      }
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }

  Future<User> LoginWithSession(String sessionID) async {
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/loginSession"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': sessionID,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> parsable = jsonDecode(res.body)[0];
      try {
        User user = User(
          parsable["id"],
          DateTime.fromMillisecondsSinceEpoch(parsable["last_login"]),
          parsable["name"],
          parsable["reportingManager_id"],
          parsable["reward_points"],
          parsable["deactivated"].toString() == "1",
        );
        user.sessionID = parsable["session_id"];
        meUser = user;
        return user;
      } catch (e) {
        throw "Password incorrect";
      }
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
