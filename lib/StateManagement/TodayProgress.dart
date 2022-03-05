import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../apis/Entities/Beat.dart';
import '../firebase_options.dart';

class TodayProgressState with ChangeNotifier, DiagnosticableTreeMixin {
  int visitText = 25;
  int scheduleVisit = 50;
  int successVisitText = 12;

  double netValueSales = 14000;
  int stdQuantitySales = 200;
  double uniqueSKU = 5;
  Beat? inProgressBeat;

}
