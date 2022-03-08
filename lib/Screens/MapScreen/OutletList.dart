import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/MapScreen/OrderHistory.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../StateManagement/MapManagement.dart';
import '../../StateManagement/ShopClosedController.dart';
import '../OrderScreen/NoOrder/NoOrderScreen.dart';
import '../OrderScreen/ShopClosedScreen.dart';

class OutletList extends StatelessWidget {
  const OutletList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CarouselSlider.builder(
      itemCount: context.watch<MapManagement>().sortedOutlets.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        context.read<MapManagement>().changeSelectedMarkerOutletByCarousel(realIndex);
        return Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, bottom: 2),
          child: GestureDetector(
            onTap: () {
              context.read<MapManagement>().changeSelectedMarkerOutlet(index);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      spreadRadius: 3)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                        width: 100,
                        child: Image.network(context
                            .watch<MapManagement>()
                            .sortedOutlets[index]
                            .img, fit: BoxFit.cover,)),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                context
                                    .watch<MapManagement>()
                                    .sortedOutlets[index]
                                    .name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                context
                                            .read<MapManagement>()
                                            .sortedOutlets[index]
                                            .dis! <
                                        1000
                                    ? context
                                            .read<MapManagement>()
                                            .sortedOutlets[index]
                                            .dis!
                                            .toStringAsFixed(2) +
                                        " m"
                                    : (context
                                                    .read<MapManagement>()
                                                    .sortedOutlets[index]
                                                    .dis! /
                                                1000)
                                            .toStringAsFixed(2) +
                                        " km",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      context
                                          .watch<MapManagement>()
                                          .sortedOutlets[index]
                                          .ownerName,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      context
                                          .watch<MapManagement>()
                                          .sortedOutlets[index]
                                          .category,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => launch(
                                    "tel://${context.read<MapManagement>().sortedOutlets[index].mobile}"),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                context
                                    .watch<MapManagement>()
                                    .sortedOutlets[index]
                                    .mobile,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "#OU${context.watch<MapManagement>().sortedOutlets[index].id.toString().padLeft(4, "0")}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  height: 30,
                                  child: MaterialButton(
                                    color: context
                                                .read<MapManagement>()
                                                .sortedOutlets[index]
                                                .dis! >
                                            20
                                        ? Colors.grey
                                        : Color(0xff34C759),
                                    onPressed: () {
                                      //commented for development purposes ~sajat
                                      // if (context.read<MapManagement>().sortedOutlets[index].dis < 20) {
                                      context
                                          .read<MapManagement>()
                                          .changeSelectedMarkerOutlet(index);
                                      context
                                          .read<OrderScreenManagement>()
                                          .singularOrder = {};
                                      context
                                          .read<OrderScreenManagement>()
                                          .dataToDisplay = null;
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (_) {
                                        return OrderScreen();
                                      }));
                                      // }
                                    },
                                    child: Text(
                                      "TAKE ORDER",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  height: 30,
                                  child: MaterialButton(
                                    color: Color(0xffE8E8E9),
                                    onPressed: () {
                                      context.read<MapManagement>().openMap();
                                    },
                                    child: Text(
                                      "VIEW ON MAP",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  height: 30,
                                  child: MaterialButton(
                                    color: context
                                                .read<MapManagement>()
                                                .sortedOutlets[index]
                                                .dis! >
                                            20
                                        ? Colors.grey
                                        : Colors.redAccent,
                                    onPressed: () {
                                      if (context
                                              .read<MapManagement>()
                                              .sortedOutlets[index]
                                              .dis! <
                                          20) {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ShopClosedScreen(context
                                              .watch<MapManagement>()
                                              .sortedOutlets[index]
                                              .id);
                                        }));
                                        context
                                            .read<ShopClosedController>()
                                            .initialize();
                                      }
                                    },
                                    child: Text(
                                      "SHOP CLOSED",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  height: 30,
                                  child: MaterialButton(
                                    color: context
                                                .read<MapManagement>()
                                                .sortedOutlets[index]
                                                .dis! >
                                            20
                                        ? Color(0xffE8E8E9)
                                        : Colors.orangeAccent,
                                    onPressed: () {
                                      context
                                          .read<MapManagement>()
                                          .changeSelectedMarkerOutlet(index);
                                      context
                                          .read<OrderScreenManagement>()
                                          .selectedNoOrderReasonGroup = null;

                                      if (context
                                              .read<MapManagement>()
                                              .sortedOutlets[index]
                                              .dis! <
                                          20) {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return NoOrderScreen();
                                        }));
                                      }
                                    },
                                    child: Text(
                                      "NO ORDER",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: context
                                                      .read<MapManagement>()
                                                      .sortedOutlets[index]
                                                      .dis! >
                                                  20
                                              ? Colors.grey
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 250,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        viewportFraction: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      carouselController: context.read<MapManagement>().carouselController,
    );
  }
}
