import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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

  TextEditingController _remarkTextEditingController = TextEditingController();
  get  remarkTextEditingController => _remarkTextEditingController;

  Timer? get timer => _timer;
  bool _isloading = false;
  get isloading => _isloading;
  List<CameraDescription> _cameras = [];

  List<CameraDescription> get cameras => _cameras;


  CameraController? get controller => _controller;

  imageSent(){
    _isloading = !_isloading;
    notifyListeners();
  }


  set timer(Timer? value) {
    _timer = value;
  }


  set cameras(List<CameraDescription> value) {
    _cameras = value;
  }

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
