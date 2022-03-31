import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import '../firebase_options.dart';
import 'LogInManagement.dart';

class SignatureManagement with ChangeNotifier, DiagnosticableTreeMixin {
  NativeDeviceOrientation? orientation;
  CameraController? cameraController;
  bool isloading = false;
  List<CameraDescription> cameras = [];


  imageSent() {
    isloading = !isloading;
    notifyListeners();
  }

  int _cir = 0;

  int get cir => _cir;

  incrementValue(int i){
  _cir = i;
  notifyListeners();
  }

}