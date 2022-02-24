import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';

import '../../StateManagement/MapManagement.dart';

class OutletList extends StatelessWidget {
  const OutletList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: context.read<MapManagement>().scrollController,
      scrollDirection: Axis.horizontal,
      children: List.generate(
        5,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              width: 300,
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
              child: Builder(builder: (context) {
                double dis = Geolocator.distanceBetween(
                  context.watch<MapManagement>().outletInfo[index].lat,
                  context.watch<MapManagement>().outletInfo[index].lng,
                  context.watch<MapManagement>().userPosition.latitude,
                  context.watch<MapManagement>().userPosition.longitude,
                );

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            context
                                .watch<MapManagement>()
                                .outletInfo[index]
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
                            dis < 1000
                                ? dis.toStringAsFixed(2) + " m"
                                : (dis / 1000).toStringAsFixed(2) + " km",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
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
                                .watch<MapManagement>()
                                .outletInfo[index]
                                .id
                                .toString(),
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
                                  "Kirana Shop",
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
                                  "A+ Segmentation",
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
                          Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            context
                                .watch<MapManagement>()
                                .outletInfo[index]
                                .mobile,
                            style: TextStyle(
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
                                color:
                                    dis > 20 ? Colors.grey : Color(0xff34C759),
                                onPressed: () {
                                  if (dis < 20) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return OrderScreen();
                                    }));
                                  }
                                },
                                child: Text(
                                  "TAKE ORDER",
                                  style: TextStyle(color: Colors.white),
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
                                onPressed: () {},
                                child: Text(
                                  "VIEW HISTORY",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
