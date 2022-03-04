import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:psr_application/Screens/BeatScreen/components/IndividualBeat.dart';

import 'ProductList.dart';
import 'SearchBar.dart';
import 'SingularProduct.dart';
import 'SingularProductHeader.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExpandableController _expandableController = ExpandableController();

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
                  4,
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
                onPressed: () {},
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
