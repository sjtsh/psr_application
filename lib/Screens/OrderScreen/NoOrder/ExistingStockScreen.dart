import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen/CompetitiveStock.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen/OwnStock.dart';

import '../../../StateManagement/MapManagement.dart';
import '../../../StateManagement/ShopClosedController.dart';
import 'NoOrderCamera.dart';

class ExistingStockScreen extends StatefulWidget {
  @override
  State<ExistingStockScreen> createState() => _ExistingStockScreenState();
}

class _ExistingStockScreenState extends State<ExistingStockScreen> {
  PageController pageController = PageController();
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      color: i == 0 ? Colors.red : Colors.blueGrey.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          "Competitive Stock",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      color: i == 1 ? Colors.green : Colors.blueGrey.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          "Own Stock",
                          style: TextStyle(color: Colors.white),
                        ),
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
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (i) {
              setState(() {
                this.i = i;
              });
            },
            children: [
              CompetitiveStock(),
              OwnStock(),
            ],
          ),
        ),
      ],
    );
  }
}
