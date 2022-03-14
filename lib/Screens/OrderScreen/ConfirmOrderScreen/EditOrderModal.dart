import 'package:flutter/material.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../SubgroupListScreen/SingularProduct.dart';

class EditOrderModal extends StatelessWidget {
  final SubGroup subGroup;

  EditOrderModal(this.subGroup);

  @override
  Widget build(BuildContext context) {
    return  SingularProduct(
        subGroup);
  }
}
