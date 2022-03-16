import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

import '../../../StateManagement/OrderScreenManagement.dart';

class ConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SubGroup subGroup;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_rounded),
                  ),
                  Expanded(
                    child: Center(
                      child: Text("Confirm Order"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.transparent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            context.read<OrderScreenManagement>().noOrderReasons.isEmpty? Expanded(child: Container(child: Center(child: Text("No Order Reason Added"),),)) : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 2),
                        blurRadius: 3)
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: context.read<OrderScreenManagement>().noOrderReasons.length,
                  itemBuilder: (_, index) {
                    var data = context
                        .read<OrderScreenManagement>()
                        .noOrderReasons
                        .entries
                        .map(
                          (e) => e.key.name)

                        .toList();
                   return  Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:
                       [
                         // ...context
                         //     .read<OrderScreenManagement>()
                         //     .noOrderReasons
                         //     .entries
                         //     .map(
                         //       (e) => Text(e.key.name.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                         //     )
                         //     .toList(),
                         Text(data[index].toString() , style: TextStyle(fontWeight:FontWeight.bold),),
                         SizedBox(height: 12,),
                         Text(context
                             .read<OrderScreenManagement>()
                             .noOrderReasons
                         [context
                             .read<OrderScreenManagement>()
                             .noOrderReasons.keys.toList()[index]]! , style: TextStyle(color: Colors.grey),),
                       ],
                     ),
                   );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
