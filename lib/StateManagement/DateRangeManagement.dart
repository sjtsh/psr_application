import 'package:flutter/foundation.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';

class DateRangeManagement with ChangeNotifier, DiagnosticableTreeMixin {
  NepaliDateTime startDate = NepaliDateTime.now();
  NepaliDateTime endDate = NepaliDateTime.now();

  List<OutletOrder>? _requestedOrders;
  bool _isRequestDisabled = true;

  setEndDate(NepaliDateTime value) {
    endDate = value;
    notifyListeners();
  }

  setStartDate(NepaliDateTime value) {
    startDate = value;
    notifyListeners();
  }

  List<OutletOrder>? get requestedOrders => _requestedOrders;

  set requestedOrders(List<OutletOrder>? value) {
    _requestedOrders = value;
    notifyListeners();
  }

  bool get isRequestDisabled => _isRequestDisabled;

  set isRequestDisabled(bool value) {
    _isRequestDisabled = value;
    notifyListeners();
  }
}
