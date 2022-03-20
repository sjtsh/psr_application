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

class ShopClosedController with ChangeNotifier, DiagnosticableTreeMixin {
  NativeDeviceOrientation? orientation;
  CameraController? controller;
  Timer? timer;
  TextEditingController remarkTextEditingController = TextEditingController();
  bool isloading = false;
  List<CameraDescription> cameras = [];
  List<LatLng> _latlngs = [];

  imageSent(){
    isloading = !isloading;
    notifyListeners();
  }

  List<LatLng> get latlngs => _latlngs;

  set latlngs(List<LatLng> value) {
    _latlngs = value;
  }

  @override
  void dispose(){
    timer?.cancel();
    print("cancelled");
    controller?.dispose();
    print("disposed");
  }
}
