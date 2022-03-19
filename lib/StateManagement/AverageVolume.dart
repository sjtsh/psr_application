import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AverageVolumeState with ChangeNotifier, DiagnosticableTreeMixin {
  int _isWeekly = 1;
  // String dateRange = "";
  // double monthlySaleVolume = 8000;
  // int monthlySKUVariance = 60;
  // double weeklySaleVolume = 8000;
  // int weeklySKUVariance = 60;
  // int todaySKUVariance = 0;
  // double todaySaleVolume = 0;


  int get isWeekly => _isWeekly;

  set isWeekly(int value) {
    _isWeekly = value;
    notifyListeners();
  }
}
