import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class CreateOrderService {

  Future insertOrder(int outletID, int orderID, String dateCreated, int primaryCount, String remarks) async {
    String URL = "https://asia-south1-psr-application-342007.cloudfunctions.net/insertOutletClosed";

    Response res = await http.post(
        Uri.parse(
          URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',

        },
        body: jsonEncode({
          'remarks': remarks,
          'outlet_id': outletID,
          'outlet_plan_id': outletID.toString(),
        })
    );

  }
}