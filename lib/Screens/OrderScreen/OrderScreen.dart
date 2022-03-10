import 'package:expandable/expandable.dart';
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
                  (index) => SingularProduct(
                      index,
                      context
                              .watch<OrderScreenManagement>()
                              .dataToDisplay?[index] ??
                          context.watch<OrderScreenManagement>().data[index]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16)),
                      child: MaterialButton(
                          onPressed: () {
                            try {
                              context
                                  .read<OrderScreenManagement>()
                                  .pageController
                                  .previousPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "PREVIOUS",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16)),
                      child: MaterialButton(
                          onPressed: () {
                          if(context.read<OrderScreenManagement>().singularOrder.containsKey("subgroup1")){
                            print("true");
                          }else{
                            print("false");
                          }
                            // try {
                            //   context
                            //       .read<OrderScreenManagement>()
                            //       .pageController
                            //       .nextPage(
                            //           duration: Duration(milliseconds: 200),
                            //           curve: Curves.easeIn);
                            // } catch (e) {
                            //   print(e);
                            // }
                          },
                          child: Text(
                            "NEXT",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
