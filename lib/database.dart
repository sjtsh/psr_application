import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'apis/Entities/Beat.dart';
import 'apis/Entities/User.dart';

User? meUser;

String getInitials(String distributorName) {
  if (distributorName.split(" ").length >= 2) {
    return distributorName.split(" ")[0].substring(0, 1).toUpperCase() +
        distributorName.split(" ")[1].substring(0, 1).toUpperCase();
  } else if (distributorName.split(" ").length == 1) {
    return distributorName.split(" ")[0].substring(0, 1).toUpperCase();
  } else {
    return "-";
  }
}
