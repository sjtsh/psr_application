import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/components/IndividualBeat.dart';
import 'package:psr_application/Screens/OrderScreen/ConfirmOrderScreen/ConfirmOrderScreen.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Entities/OutletOrder.dart';

import '../../StateManagement/MapManagement.dart';
import 'ProductList.dart';
import 'SearchBar.dart';
import 'SingularProduct.dart';
import 'SingularProductHeader.dart';

class OrderScreen extends StatelessWidget {
  final OutletOrder? order;


  OrderScreen({this.order});

  @override
  Widget build(BuildContext context) {
    int index ;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Order",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller:
                    context.read<OrderScreenManagement>().pageController,
                children: List.generate(
                  context
                          .watch<OrderScreenManagement>()
                          .dataToDisplay
                          ?.length ??
                      context.read<OrderScreenManagement>().data.length,
                  (index) {
                    return SingularProduct(
                      index,
                      context
                              .watch<OrderScreenManagement>()
                              .dataToDisplay?[index] ??
                          context.watch<OrderScreenManagement>().data[index]);}
                ),
                onPageChanged: (ints){
                  print(ints);
                  context.read<OrderScreenManagement>().pageViewInt= ints;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
