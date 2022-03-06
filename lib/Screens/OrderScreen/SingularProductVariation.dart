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
                .singularOrder[widget.subGroup]?[widget.sku] == null ?
            "": context
                .read<OrderScreenManagement>()
                .singularOrder[widget.subGroup]![widget.sku]! ~/ widget.sku.cf)
        .toString();
    alternative.text = (context
                .read<OrderScreenManagement>()
                .singularOrder[widget.subGroup]?[widget.sku] == null ?
            "": context
                .read<OrderScreenManagement>()
                .singularOrder[widget.subGroup]![widget.sku]! % widget.sku.cf)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        color: Color(0xffE8F5E9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              widget.sku.name,
            ),
            Expanded(child: Container()),
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    controller: alternative,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    onChanged: (text) {
                      int a = (int.tryParse(primary.text) ?? 0)  * widget.sku.cf +
                          (int.tryParse(alternative.text) ?? 0);
                      if (a != 0) {
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder
                            .containsKey(widget.subGroup)) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup]![widget.sku] = a;
                        } else {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup] = {widget.sku: a};
                        }
                      } else {
                        context
                            .read<OrderScreenManagement>()
                            .singularOrder[widget.subGroup]
                            ?.remove(widget.sku);
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder[widget.subGroup]
                            ?.keys
                            .isEmpty ??
                            false) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder
                              .remove(widget.subGroup);
                        }
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: widget.sku.secondaryUnit,
                      border: InputBorder.none,
                      hintStyle:
                      TextStyle(color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black.withOpacity(0.1)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    controller: primary,
                    cursorWidth: 1,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.blue,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    onChanged: (input) {
                      int a = (int.tryParse(primary.text) ?? 0)  * widget.sku.cf +
                          (int.tryParse(alternative.text) ?? 0);
                      if (a != 0) {
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder
                            .containsKey(widget.subGroup)) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup]![widget.sku] = a;
                        } else {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[widget.subGroup] = {widget.sku: a};
                        }
                      } else {
                        context
                            .read<OrderScreenManagement>()
                            .singularOrder[widget.subGroup]
                            ?.remove(widget.sku);
                        if (context
                                .read<OrderScreenManagement>()
                                .singularOrder[widget.subGroup]
                                ?.keys
                                .isEmpty ??
                            false) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder
                              .remove(widget.subGroup);
                        }
                      }
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: widget.sku.primaryUnit,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
