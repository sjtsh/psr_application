import 'package:flutter/foundation.dart';
import 'package:psr_application/HiveBox/HiveBox.dart';
import 'package:psr_application/apis/Entities/Performance.dart';

import '../HiveBox/HiveBoxLocal.dart';

class DataManagement with ChangeNotifier, DiagnosticableTreeMixin {
  late HiveBox hiveBox;
  late HiveBoxLocal hiveBoxLocal;
}
