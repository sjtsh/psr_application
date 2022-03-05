import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ShopClosedScreen.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';

import '../../../StateManagement/MapManagement.dart';
import '../../../StateManagement/TodayProgress.dart';
import '../../MapScreen/MapScreen.dart';

class TodayProgress extends StatelessWidget {
  const TodayProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text("Today's Progress"),
              Expanded(child: Container()),
              Text(
                context.watch<TodayProgressState>().inProgressBeat?.name ?? "",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0,2),blurRadius: 3,spreadRadius: 3)]
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Countup(
                      begin: 0,
                      end: context.watch<TodayProgressState>().visitText + 0.0,
                      suffix:
                          "/${context.watch<TodayProgressState>().scheduleVisit.toString()} visits",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    Text(
                      context
                              .watch<TodayProgressState>()
                              .successVisitText
                              .toString() +
                          " productive visits",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0,2),blurRadius: 3,spreadRadius: 3)]
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: context
                                .watch<TodayProgressState>()
                                .netValueSales,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            separator: ",",
                          ),
                          Text(
                            "Net Sales Value",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0,2),blurRadius: 3,spreadRadius: 3)]
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: context
                                    .watch<TodayProgressState>()
                                    .stdQuantitySales +
                                0.0,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Std Quantity",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0,2),blurRadius: 3,spreadRadius: 3)]
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: context.watch<TodayProgressState>().uniqueSKU +
                                0.0,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Average SKU",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Geolocator.getCurrentPosition().then((event) {
                context
                    .read<MapManagement>()
                    .initializeMarkers(LatLng(event.latitude, event.longitude));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MapScreen()));
              });
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Continue Retailing",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
