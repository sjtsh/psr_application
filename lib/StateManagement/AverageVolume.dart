import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/OutletOrder.dart';
import '../firebase_options.dart';

class AverageVolumeState with ChangeNotifier, DiagnosticableTreeMixin {
  HollowBeat? inProgressBeat;
  int _isWeekly = 1;
  int get isWeekly => _isWeekly;
  set isWeekly(int value) {
    _isWeekly = value;
    notifyListeners();
  }
}
