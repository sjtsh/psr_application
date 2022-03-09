import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/NoOrder/NoOrderScreen.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';
import '../../StateManagement/OrderScreenManagement.dart';
import 'SingularProductHeader.dart';
import 'SingularProductVariation.dart';

class SingularProduct extends StatelessWidget {
  final int index;
  final SubGroup subGroup;

  SingularProduct(this.index, this.subGroup);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            child: SingularProductHeader(index, subGroup),
          ),
          Container(
            height: 300,
            color: Colors.white,
            child: CarouselSlider(
              options: CarouselOptions(
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                viewportFraction: 0.8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: List.generate(subGroup.skus.length,
                  (a) => SingularProductVariation(subGroup.skus[a], subGroup)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ExpandablePanel(
              collapsed: ExpandableButton(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Existing Stock",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              expanded: Column(
                children: [
                  ExpandableButton(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f2f2),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Existing Stock",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                      border: Border(bottom: BorderSide(
                        color: Colors.black.withOpacity(0.5),)
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Own Stock",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(width: 4,),
                      Text("OR"),
                      SizedBox(width: 4,),
                      Expanded(
                        child: Divider(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(
                        color: Colors.black.withOpacity(0.5),)
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Competing Stock",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 60,
              width: double.infinity,
              child: TextFormField(
                controller: context
                    .read<OrderScreenManagement>()
                    .noOrderRemarkController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.book_outlined),
                    hintText: "Other Reasons",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.green)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black))),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
