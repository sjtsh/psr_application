import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import '../LocalNoSQL/Performance.dart';
import '../apis/Entities/Beat.dart';
import '../firebase_options.dart';

class TodayProgressState with ChangeNotifier, DiagnosticableTreeMixin {
  HollowBeat? inProgressBeat;
  Box<dynamic>? orderBox;
  Box<dynamic>? performanceBox;

}
