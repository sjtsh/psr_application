import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AverageVolumeState with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isWeekly = true;
  String _dateRange = "18-24 Sep 2022";
  double _monthlySaleVolume = 8000;
  double _monthlySKUVariance = 60;
  double _weeklySaleVolume = 8000;
  double _weeklySKUVariance = 60;

  double get weeklySaleVolume => _weeklySaleVolume;

  set weeklySaleVolume(double value) {
    _weeklySaleVolume = value;
  }

  double get weeklySKUVariance => _weeklySKUVariance;

  set weeklySKUVariance(double value) {
    _weeklySKUVariance = value;
  }

  double get monthlySaleVolume => _monthlySaleVolume;

  set monthlySaleVolume(double value) {
    _monthlySaleVolume = value;
  }

  double get monthlySKUVariance => _monthlySKUVariance;

  set monthlySKUVariance(double value) {
    _monthlySKUVariance = value;
  }

  String get dateRange => _dateRange;

  set dateRange(String value) {
    _dateRange = value;
  }

  bool get isWeekly => _isWeekly;

  set isWeekly(bool value) {
    _isWeekly = value;
    notifyListeners();
  }
}
