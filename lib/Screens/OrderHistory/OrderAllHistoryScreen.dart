import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/DataManagement.dart';
import 'package:psr_application/apis/Services/OrderService.dart';

import '../../Skeletons/OrdersSkeleton.dart';
import '../../StateManagement/AverageVolume.dart';

import 'SingularOrder.dart';

class OrderAllHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffF1F2F6),
          body: Column(
            children: [
              Container(
                height: 60,
                color: const Color(0xffF1F2F6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                    Expanded(child: Center(child: Text("Beat Plan Orders"))),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                    context.watch<DataManagement>().hiveBox.outletOrders.isEmpty
                        ? Center(child: Text("No Orders Found"))
                        : ListView(
                            children: [
                              ...context
                                  .watch<DataManagement>()
                                  .hiveBox
                                  .outletOrders
                                  .reversed
                                  .map(
                                    (e) => SingularOrder(e),
                                  )
                                  .toList(),
                            ],
                          ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          )),
    );
  }
}
