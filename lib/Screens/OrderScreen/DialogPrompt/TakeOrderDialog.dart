import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../StateManagement/DataManagement.dart';
import '../../../StateManagement/OrderScreenManagement.dart';
import '../../../StateManagement/OrderVariation.dart';
import '../SubgroupListScreen/SubGroupListScreen.dart';

class TakeOrderDialog extends StatelessWidget {
  const TakeOrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            color: Colors.transparent,
            child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xffF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: SizedBox(
                  height: 170,
                  width: 250,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 20, right: 20, left: 20),
                        child: Text(
                          "Would you like to restore orders?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Divider(
                        height: 2,
                        thickness: 2,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return SubGroupListScreen();
                                      }));
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            VerticalDivider(thickness: 2),
                            Expanded(child: Container()),

                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTap: (){
                                  context
                                      .read<OrderScreenManagement>()
                                      .singularOrder = {};
                                  context
                                      .read<OrderScreenManagement>()
                                      .competitiveExistingStock = {};
                                  context
                                      .read<OrderScreenManagement>()
                                      .ownExistingStock = {};
                                  context
                                      .read<OrderScreenManagement>()
                                      .noOrderReasons = {};
                                  context
                                      .read<OrderScreenManagement>()
                                      .dataToDisplay = null;
                                  context.read<OrderVariation>().isAllDone = false;
                                  // context
                                  //     .read<OrderScreenManagement>()
                                  //     .keys =
                                  //     List.generate(
                                  //         context
                                  //             .read<DataManagement>()
                                  //             .hiveBox.subgroups
                                  //             .length,
                                  //             (index) => GlobalKey());
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
