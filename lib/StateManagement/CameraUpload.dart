import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class CameraUpload with ChangeNotifier, DiagnosticableTreeMixin {
  Future<String> uploadFile(File file, String name, int userID) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: 'psrapplication',
    );
    Reference ref = firebase_storage.FirebaseStorage.instanceFor(
            app: Firebase.app('psrapplication'))
        .ref('camera_uploads/$userID/$name');
    ref.putFile(file);
    return ref.getDownloadURL();
  }
}
