import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import '../firebase_options.dart';
import 'LogInManagement.dart';

class ShopClosedController with ChangeNotifier, DiagnosticableTreeMixin {
  NativeDeviceOrientation? _orientation;
  CameraController? _controller;
  Timer? _timer;

  Timer? get timer => _timer;

  set timer(Timer? value) {
    _timer = value;
  }

  List<CameraDescription> _cameras = [];

  List<CameraDescription> get cameras => _cameras;

  set cameras(List<CameraDescription> value) {
    _cameras = value;
  }

  CameraController? get controller => _controller;

  set controller(CameraController? value) {
    _controller = value;
  }

  NativeDeviceOrientation? get orientation => _orientation;

  set orientation(NativeDeviceOrientation? value) {
    _orientation = value;
  }

  void dispose(){

    timer?.cancel();
    print("cancelled");
    controller?.dispose();
    print("disposed");
  }

  void initialize() {
    print("initialization started");
    NativeDeviceOrientationCommunicator()
        .orientation(useSensor: true)
        .then((value) {
      _orientation = value;
      notifyListeners();
      print("orientation found $_orientation");
    });
    controller = CameraController(cameras[0], ResolutionPreset.high,);
    controller?.initialize();
    notifyListeners();
    print("initialized");

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      NativeDeviceOrientationCommunicator()
          .orientation(useSensor: true)
          .then((value) {
        _orientation = value;
        notifyListeners();
      });
    });
  }
}
