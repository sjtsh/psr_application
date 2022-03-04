
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';
import '../apis/Entities/Beat.dart';
import '../apis/Entities/Outlet.dart';
import '../firebase_options.dart';

class BeatManagement with ChangeNotifier, DiagnosticableTreeMixin {
  List<HollowBeat> _beats = [];
  List<OutletOrder> _outletOrders = [];


  set beats(List<HollowBeat> value) {
    _beats = value;
  }

  List<OutletOrder> get outletOrders => _outletOrders;

  set outletOrders(List<OutletOrder> value) {
    _outletOrders = value;
  }

  List<HollowBeat> get beats => _beats;


}
