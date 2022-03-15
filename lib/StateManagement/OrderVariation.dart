import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/SKU.dart';
import '../firebase_options.dart';

class OrderVariation with ChangeNotifier, DiagnosticableTreeMixin {
  Map<SKU, int> _tempSubGroupVariation = {};

  bool _isAllDone = false;


  bool get isAllDone => _isAllDone;

  set isAllDone(bool value) {
    _isAllDone = value;
  }

  Map<SKU, int> get tempSubGroupVariation => _tempSubGroupVariation;

  set tempSubGroupVariation(Map<SKU, int> value) {
    _tempSubGroupVariation = value;
  }
}
