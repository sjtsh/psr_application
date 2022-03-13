import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../StateManagement/OrderScreenManagement.dart';
import '../../apis/Entities/SKU.dart';

class SingularProductVariation extends StatefulWidget {
  SKU sku;
  SubGroup subGroup;

  SingularProductVariation(this.sku, this.subGroup);

  @override
  State<SingularProductVariation> createState() =>
      _SingularProductVariationState();
}

class _SingularProductVariationState extends State<SingularProductVariation> {
  TextEditingController primary = TextEditingController();
  TextEditingController alternative = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    primary.text = (context
        .read<OrderScreenManagement>()
        .singularOrder[widget.subGroup]?[widget.sku] ==
        null
        ? ""
        : context
        .read<OrderScreenManagement>()
        .singularOrder[widget.subGroup]![widget.sku]! ~/
        widget.sku.cf)
        .toString();
    alternative.text = (context
        .read<OrderScreenManagement>()
        .singularOrder[widget.subGroup]?[widget.sku] ==
        null
        ? ""
        : context
        .read<OrderScreenManagement>()
        .singularOrder[widget.subGroup]![widget.sku]! %
        widget.sku.cf)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/oats.jpg"),
          fit: BoxFit.cover,
        ),
        // color: Color(0xffE8F5E9),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
