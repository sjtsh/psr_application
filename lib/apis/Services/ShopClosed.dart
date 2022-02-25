import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../../database.dart';
import '../../firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class OutletClosedService {
  Future<bool> insertOutletClosed(
      File file, String name, String userID, String remarks, int outletID) async {
    String downloadUrl =
        await uploadFile(file: file, name: name, userID: userID);
        print(downloadUrl);
    Response res = await http.post(
      Uri.parse(
          "https://asia-south1-psr-application-342007.cloudfunctions.net/insertOutletClosed"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'session_id': (meUser?.sessionID ?? ""),
      },
      body: jsonEncode({
          'img': downloadUrl,
          'remarks': remarks,
          'outlet_id': outletID.toString(),
        })
    );
    print(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Status code is ${res.statusCode}";
    }
  }

  Future<String> uploadFile(
      {required File file, required String name, required String userID}) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: 'psrapplication',
    );
    TaskSnapshot uploading = await firebase_storage.FirebaseStorage.instanceFor(
            app: Firebase.app('psrapplication'))
        .ref('camera_uploads/$userID/$name')
        .putFile(file);
    return uploading.ref.getDownloadURL();
  }
}