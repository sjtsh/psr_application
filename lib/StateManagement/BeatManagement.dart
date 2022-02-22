
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../apis/Entities/Beat.dart';
import '../firebase_options.dart';

class BeatManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<Beat> _allBeatsLocal = [];


  set allBeatsLocal(List<Beat> value) {
    _allBeatsLocal = value;
  }

  List<Beat> get allBeatsLocal => _allBeatsLocal;

}
