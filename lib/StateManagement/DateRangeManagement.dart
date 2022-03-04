import 'package:flutter/foundation.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';

class DateRangeManagement with ChangeNotifier, DiagnosticableTreeMixin {
  NepaliDateTime _startDate = NepaliDateTime(2078);
  NepaliDateTime _endDate = NepaliDateTime(2078);

  List<OutletOrder>? _requestedOrders;
  bool _isRequestDisabled = false;

  NepaliDateTime get startDate => _startDate;

  set startDate(NepaliDateTime value) {
    _startDate = value;
  }

  NepaliDateTime get endDate => _endDate;

  set endDate(NepaliDateTime value) {
    _endDate = value;
  }

  setEndDate(NepaliDateTime value) {
    _endDate = value;
    notifyListeners();
  }

  setStartDate(NepaliDateTime value) {
    _startDate = value;
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
