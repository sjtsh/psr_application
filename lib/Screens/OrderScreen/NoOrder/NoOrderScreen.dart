import 'package:flutter/material.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderReasonScreen.dart';

class NoOrderScreen extends StatefulWidget {
  @override
  State<NoOrderScreen> createState() => _NoOrderScreenState();
}

class _NoOrderScreenState extends State<NoOrderScreen> {
  PageController pageController = PageController(initialPage: 0);

  int i = 0;

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
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: i == 0 ? Colors.white : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                                color: i == 0
                                    ? Colors.blue
                                    : Colors.blue.withOpacity(0.1),
                                width: 3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Existing Stock",
                            style: TextStyle(
                                color: i == 0
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
                        print("turning");
                        pageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: i == 1 ? Colors.white : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                                color: i == 1
                                    ? Colors.blue
                                    : Colors.blue.withOpacity(0.1),
                                width: 3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "No Order Reason",
                            style: TextStyle(
                                color: i == 1
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
              child: PageView(
                onPageChanged: (i) {
                  setState(() {
                    this.i = i;
                  });
                },
                controller: pageController,
                children: [
                  ExistingStockScreen(),
                  NoOrderReasonScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
