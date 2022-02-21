import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class CameraUpload with ChangeNotifier, DiagnosticableTreeMixin {
  Future<String> uploadFile(
      {required File file, required String name, required int userID}) async {
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
