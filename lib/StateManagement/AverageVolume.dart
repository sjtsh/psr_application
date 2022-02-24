import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class AverageVolumeState with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isWeekly = true;
  String _dateRange = "18-24 Sep 2022";
  double _saleVolume = 6000;
  int _skuVariance = 25;
  double _monthlySaleVolume = 8000;
  int _monthlySKUVariance = 60;


  double get monthlySaleVolume => _monthlySaleVolume;

  set monthlySaleVolume(double value) {
    _monthlySaleVolume = value;
  }

  double get saleVolume => _saleVolume;

  int get monthlySKUVariance => _monthlySKUVariance;

  set monthlySKUVariance(int value) {
    _monthlySKUVariance = value;
  }

  set saleVolume(double value) {
    _saleVolume = value;
  }

  int get skuVariance => _skuVariance;

  set skuVariance(int value) {
    _skuVariance = value;
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
