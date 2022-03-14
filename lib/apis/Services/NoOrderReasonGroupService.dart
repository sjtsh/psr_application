// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
//
// import '../../database.dart';
// import '../Entities/NoOrderReasonGroup.dart';
//
// class NoOrderReasonGroupService {
//
//   Future<bool> insertNoOrder(int outletPlanID, String remarks, String subGroup) async{
//
//     Response res = await http.post(
//         Uri.parse(
//             "https://asia-south1-psr-application-342007.cloudfunctions.net/insertNoOrder"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'session_id': (meUser?.sessionID ?? ""),
//         },
//         body: jsonEncode({
//           'remarks': remarks,
//           'outlet_plan_id': outletPlanID.toString(),
//           'sub_group_name': subGroup,
//           "time_created": NepaliDateTime.now().toString().substring(0,19),
//         })
//     );
//     if (res.statusCode == 200) {
//       return true;
//     } else {
//       throw "Status code is ${res.statusCode}";
//     }
//   }
//
//   // Future<bool> getNoOrderReasonGroups(BuildContext context) async {
//   //   Response res = await http.get(
//   //     Uri.parse(
//   //         "https://asia-south1-psr-application-342007.cloudfunctions.net/getNoOrderReasonGroups"),
//   //     headers: <String, String>{
//   //       'Content-Type': 'application/json; charset=UTF-8',
//   //       'session_id': (meUser?.sessionID ?? ""),
//   //     },
//   //   );
//   //   if (res.statusCode == 200) {
//   //     List<dynamic> parsable = jsonDecode(res.body);
//   //     List<NoOrderReasonGroup> noOrderReasonGroups = parsable
//   //         .map(
//   //           (e) => NoOrderReasonGroup(
//   //             e["id"],
//   //             e["remarks"],
//   //           ),
//   //         )
//   //         .toList();
//   //     context.read<OrderScreenManagement>().noOrderReasons =
//   //         noOrderReasonGroups;
//   //     return true;
//   //   } else {
//   //     throw "Status code is ${res.statusCode}";
//   //   }
//   // }
// }
