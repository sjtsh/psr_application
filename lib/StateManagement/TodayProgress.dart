import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../apis/Entities/Beat.dart';
import '../firebase_options.dart';

class TodayProgressState with ChangeNotifier, DiagnosticableTreeMixin {
  int _visitText = 25;
  int _scheduleVisit = 50;
  int _successVisitText = 12;

  double _netValueSales = 14000;
  int _stdQuantitySales = 200;
  double _uniqueSKU = 5;
  Beat? _inProgressBeat;

  Beat? get inProgressBeat => _inProgressBeat;

  set inProgressBeat(Beat? value) {
    _inProgressBeat = value;
    notifyListeners();
  }


  int get stdQuantitySales => _stdQuantitySales;

  set stdQuantitySales(int value) {
    _stdQuantitySales = value;
  }

  int get scheduleVisit => _scheduleVisit;
  set scheduleVisit(int value) {
    _scheduleVisit = value;
  }

  double get uniqueSKU => _uniqueSKU;

  set uniqueSKU(double value) {
    _uniqueSKU = value;
  }

  int get visitText => _visitText;

  set visitText(int value) {
    _visitText = value;
  }

  int get successVisitText => _successVisitText;

  set successVisitText(int value) {
    _successVisitText = value;
  }

  double get netValueSales => _netValueSales;

  set netValueSales(double value) {
    _netValueSales = value;
  }
}
