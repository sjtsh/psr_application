import 'package:flutter/material.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderReasonScreen.dart';

import '../../../apis/Entities/SubGroup.dart';

class NoOrderScreen extends StatefulWidget {
  final SubGroup subGroup;
  final Function refresh;

  NoOrderScreen(this.subGroup, this.refresh);

  @override
  State<NoOrderScreen> createState() => _NoOrderScreenState();
}

class _NoOrderScreenState extends State<NoOrderScreen> {
  int outsideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Center(
                      child: Text("No Order Screen"),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          outsideIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: outsideIndex == 0
                              ? Colors.white
                              : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                                color: outsideIndex == 0
                                    ? Colors.blue
                                    : Colors.blue.withOpacity(0.1),
                                width: 3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Existing Stock",
                            style: TextStyle(
                                color: outsideIndex == 0
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          outsideIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: outsideIndex == 1
                              ? Colors.white
                              : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                                color: outsideIndex == 1
                                    ? Colors.blue
                                    : Colors.blue.withOpacity(0.1),
                                width: 3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "No Order Reason",
                            style: TextStyle(
                                color: outsideIndex == 1
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: outsideIndex,
                children: [
                  ExistingStockScreen(widget.subGroup, widget.refresh),
                  NoOrderReasonScreen(widget.subGroup, widget.refresh),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
