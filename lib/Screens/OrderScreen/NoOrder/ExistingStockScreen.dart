import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen/CompetitiveStock.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/ExistingStockScreen/OwnStock.dart';

import '../../../StateManagement/MapManagement.dart';
import '../../../StateManagement/ShopClosedController.dart';
import '../../../apis/Entities/SubGroup.dart';
import 'NoOrderCamera.dart';

class ExistingStockScreen extends StatefulWidget {
  final SubGroup subGroup;
  final Function refresh;

  ExistingStockScreen(this.subGroup, this.refresh);

  @override
  State<ExistingStockScreen> createState() => _ExistingStockScreenState();
}

class _ExistingStockScreenState extends State<ExistingStockScreen> {
  int insideIndex = 0;

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
                      setState(() {
                        this.insideIndex = 0;
                      });
                    },
                    child: Container(
                      color: insideIndex == 0
                          ? Colors.red
                          : Colors.blueGrey.withOpacity(0.5),
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
                      setState(() {
                        this.insideIndex = 1;
                      });
                    },
                    child: Container(
                      color: insideIndex == 1
                          ? Colors.green
                          : Colors.blueGrey.withOpacity(0.5),
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
          child: IndexedStack(
            index: insideIndex,
            children: [
              CompetitiveStock(widget.subGroup, widget.refresh),
              OwnStock(widget.subGroup, widget.refresh),
            ],
          ),
        ),
      ],
    );
  }
}
