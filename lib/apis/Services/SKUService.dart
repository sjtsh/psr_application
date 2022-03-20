import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../database.dart';
import '../Entities/SKU.dart';

class SKUService {
  Future<List<SubGroup>> getSKUs() async {
    Response res = await http.get(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/getSKUs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> parsable = jsonDecode(res.body);
      List<SubGroup> subgroups = parsable.entries.map(
        (e) {
          Map<String, dynamic> bMap = e.value["skus"];
          List<SKU> skus = bMap.entries
              .map((f) {
                    return SKU.fromJson(int.parse(f.key.toString()),
                        f.value as Map<String, dynamic>);
                  })
              .toList();
          return SubGroup(
            e.key,
            e.value["product_group"],
            skus,
          );
        },
      ).toList();
      return subgroups;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }
}
