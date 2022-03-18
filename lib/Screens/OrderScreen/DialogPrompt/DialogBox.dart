import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen/CompetitveStockScreen.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen/OwnStock.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderReasonScreen.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../../StateManagement/NoOrderManagement.dart';
import '../NoOrder/NoOrderScreen.dart';

class MyDialogBox extends StatefulWidget {
  final SubGroup e;

  MyDialogBox(this.e,);

  @override
  State<MyDialogBox> createState() => _MyDialogBoxState();
}

class _MyDialogBoxState extends State<MyDialogBox> {
  bool onExistingStockTap = false;
  bool onNoOrderReasonTap = false;

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
            height: 190,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
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
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        onExistingStockTap =! onExistingStockTap;
                      });

                      if (onExistingStockTap == false) {
                        context
                            .read<NoOrderManagement>()
                            .initializeNoOrder(widget.e, context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return CompetitiveStockScreen(widget.e);
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.grey.shade300,
                            )
                          ]),
                      child: Center(
                        child: Text(
                          onExistingStockTap == true
                              ? "Competitive Stock"
                              : "Existing Stock",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {

                      if (onNoOrderReasonTap == false) {
                        context
                            .read<NoOrderManagement>()
                            .initializeNoOrder(widget.e, context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return NoOrderReasonScreen(widget.e);
                            },
                          ),
                        );
                      }
                      if (onExistingStockTap == true) {
                        context
                            .read<NoOrderManagement>()
                            .initializeNoOrder(widget.e, context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return OwnStock(widget.e,);
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.grey.shade300,
                            )
                          ]),
                      child: Center(
                        child: Text(
                          onExistingStockTap == true
                              ? "Own Stock"
                              : "No Order Reason",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
