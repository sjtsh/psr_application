import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AverageVolumeState with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isWeekly = true;
  String dateRange = "18-24 Sep 2022";
  double monthlySaleVolume = 8000;
  double monthlySKUVariance = 60;
  double weeklySaleVolume = 8000;
  double weeklySKUVariance = 60;


  bool get isWeekly => _isWeekly;

  set isWeekly(bool value) {
    _isWeekly = value;
    notifyListeners();
  }
}
