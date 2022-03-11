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
  NativeDeviceOrientation? orientation;
  CameraController? controller;
  Timer? timer;
  TextEditingController remarkTextEditingController = TextEditingController();
  bool isloading = false;
  List<CameraDescription> cameras = [];
  String? _noOrderPhotoLocalUrl;


  String? get noOrderPhotoLocalUrl => _noOrderPhotoLocalUrl;

  set noOrderPhotoLocalUrl(String? value) {
    _noOrderPhotoLocalUrl = value;
    notifyListeners();
  }

  imageSent(){
    isloading = !isloading;
    notifyListeners();
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
      orientation = value;
      notifyListeners();
      print("orientation found $orientation");
    });
    controller = CameraController(cameras[0], ResolutionPreset.high,);
    controller?.initialize();
    notifyListeners();
    print("initialized");

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      NativeDeviceOrientationCommunicator()
          .orientation(useSensor: true)
          .then((value) {
        orientation = value;
        notifyListeners();
      });
    });
  }
}
