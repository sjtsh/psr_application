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
                  color: const Color(0xffF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: SizedBox(
                  height: 170,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6,),
                        const Text(
                          "Would you like to restore orders?",
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        const Text(
                          "Orders that have already been placed will be visible.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) {
                                      return SubGroupListScreen();
                                    }));
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Restore",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
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
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child:  Text(
                                    "Delete",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
