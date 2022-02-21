import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Entities/User.dart';

class UserService {
  Future<User> Login(String username, String password) async {
    Response res = await http.get(
      Uri.parse("uri"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'username': username,
        'password': password,
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> parsable = jsonDecode(res.body);
      User user = User(
          parsable["id"],
          DateTime.parse(parsable["last_login"]),
          parsable["name"],
          parsable["reportingManager"],
          parsable["deactivated"] == "true");
      user.sessionID = parsable["session_id"];
      return user;
    } else {
      throw "Status code is not 200";
    }
  }
}
