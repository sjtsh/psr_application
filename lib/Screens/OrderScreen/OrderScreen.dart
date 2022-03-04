import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/components/IndividualBeat.dart';
import 'package:psr_application/Screens/OrderScreen/ConfirmOrderScreen/ConfirmOrderScreen.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';

import '../../StateManagement/MapManagement.dart';
import 'ProductList.dart';
import 'SearchBar.dart';
import 'SingularProduct.dart';
import 'SingularProductHeader.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Order",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.normal),
                ),
              ),
              SearchBarState(),
              Column(
                children: List.generate(
                  context.read<OrderScreenManagement>().data.length,
                  (index) => SingularProduct(index),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(16)),
            child: MaterialButton(
                onPressed: () {
                  print(
                      "${context.read<MapManagement>().selectedOutlet!.id} outlet id");
                  print(
                      "${context.read<OrderScreenManagement>().singularOrder} map");
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ConfirmOrderScreen()));
                },
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        )
      ]),
    );
  }
}
