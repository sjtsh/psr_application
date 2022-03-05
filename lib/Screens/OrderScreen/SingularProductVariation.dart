import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../StateManagement/OrderScreenManagement.dart';
import '../../apis/Entities/SKU.dart';

class SingularProductVariation extends StatelessWidget {
  TextEditingController primary = TextEditingController();
  TextEditingController alternative = TextEditingController();

  SKU sku;
  SubGroup subGroup;

  SingularProductVariation(this.sku, this.subGroup);

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
        color: Colors.black.withOpacity(0.05),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              sku.name,
            ),
            Expanded(child: Container()),
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
                      int a = (int.tryParse(primary.text) ?? 0) +
                          (int.tryParse(alternative.text) ?? 0) * sku.cf;
                      if (a != 0) {
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder
                            .containsKey(subGroup)) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[subGroup]![sku] = a;
                        } else {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[subGroup] = {sku: a};
                        }
                      } else {
                        context
                            .read<OrderScreenManagement>()
                            .singularOrder[subGroup]
                            ?.remove(sku);
                        if (context
                                .read<OrderScreenManagement>()
                                .singularOrder[subGroup]
                                ?.keys
                                .isEmpty ??
                            false) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder
                              .remove(subGroup);
                        }
                      }
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: sku.primaryUnit,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                      border: InputBorder.none,
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
                      int a = (int.tryParse(primary.text) ?? 0) +
                          (int.tryParse(alternative.text) ?? 0) * sku.cf;
                      if (a != 0) {
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder
                            .containsKey(subGroup)) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[subGroup]![sku] = a;
                        } else {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder[subGroup] = {sku: a};
                        }
                      } else {
                        context
                            .read<OrderScreenManagement>()
                            .singularOrder[subGroup]
                            ?.remove(sku);
                        if (context
                            .read<OrderScreenManagement>()
                            .singularOrder[subGroup]
                            ?.keys
                            .isEmpty ??
                            false) {
                          context
                              .read<OrderScreenManagement>()
                              .singularOrder
                              .remove(subGroup);
                        }
                      }
                    },
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: sku.secondaryUnit,
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
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
