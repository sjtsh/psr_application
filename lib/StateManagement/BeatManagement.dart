
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/Outlet.dart';
import '../firebase_options.dart';

class BeatManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<Beat> _allBeatsLocal = [];


  set allBeatsLocal(List<Beat> value) {
    _allBeatsLocal = value;
  }

  set allOutletsLocal(List<Outlet> value) {
    for (Outlet element in value) {
      for (Beat beat in _allBeatsLocal) {
        if(beat.id == element.beatID){
          beat.outlets.add(element);
        }
      }
    }
  }


  List<Beat> get allBeatsLocal => _allBeatsLocal;


}
