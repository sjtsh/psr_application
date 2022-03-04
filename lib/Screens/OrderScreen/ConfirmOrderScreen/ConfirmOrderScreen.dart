import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';

import '../../../StateManagement/OrderScreenManagement.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: [
            Row(
              children: [
                Text("Date Created"),
                Expanded(child: Container()),
                Text("${context.read<MapManagement>().selectedOutlet?.id}"),
              ],
            ),
            Row(
              children: [
                Text("Outlet Id:"),
                Expanded(child: Container()),
                Text("${context.read<MapManagement>().selectedOutlet?.id}"),
              ],
            ),
            Expanded(
              child: ListView.builder( itemCount: context.watch<OrderScreenManagement>().singularOrder.values.length,
                  itemBuilder: (_, i){

                return  Row(
                  children: [
                    Text("SKU quantity:"),
                    Expanded(child: Container()),
                    Text("${context.watch<OrderScreenManagement>().singularOrder["$i"]}"),
                  ],
                );
              }),
            )


          ],
        )
      ),
    );
  }
}
