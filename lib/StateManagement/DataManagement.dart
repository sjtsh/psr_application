import 'package:flutter/foundation.dart';
import 'package:psr_application/HiveBox/HiveBox.dart';
import 'package:psr_application/apis/Entities/Performance.dart';

class DataManagement with ChangeNotifier, DiagnosticableTreeMixin {
  late HiveBox hiveBox;
}
