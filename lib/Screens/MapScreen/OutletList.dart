import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/OrderScreen.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';

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
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              width: 150,
              child: Builder(builder: (context) {
                double dis = Geolocator.distanceBetween(
                  context.watch<MapManagement>().sortedOutlets[index].lat,
                  context.watch<MapManagement>().sortedOutlets[index].lng,
                  context.watch<MapManagement>().userPosition.latitude,
                  context.watch<MapManagement>().userPosition.longitude,
                );

                return Column(
                  children: [
                    Text(context.watch<MapManagement>().sortedOutlets[index].name),
                    Text(dis < 1000
                        ? dis.toStringAsFixed(2) + " m"
                        : (dis / 1000).toStringAsFixed(2) + " km"),
                    Text(context
                        .watch<MapManagement>()
                        .sortedOutlets[index]
                        .id
                        .toString()),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      height: 20,
                      child: MaterialButton(
                        color: dis > 20 ? Colors.grey : Colors.green,
                        onPressed: () {
                          if (dis < 20){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                              return OrderScreen();
                            }));
                          }
                        },
                        child: Text(
                          "Take order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
