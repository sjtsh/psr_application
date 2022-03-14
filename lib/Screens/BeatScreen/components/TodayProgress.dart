import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/OrderScreen/ShopClosedScreen/ShopClosedScreen.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';

import '../../../StateManagement/MapManagement.dart';
import '../../../StateManagement/TodayProgress.dart';
import '../../MapScreen/MapScreen.dart';

class TodayProgress extends StatelessWidget {
  final int isWeekly;
  final int todaySKUVariance;
  final int rewardPoints;
  final double totalSaleVolume;
  final int successVisitText;
  final int scheduledVisit;

  TodayProgress(this.isWeekly, this.todaySKUVariance, this.rewardPoints,
      this.totalSaleVolume, this.successVisitText, this.scheduledVisit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                isWeekly == 1
                    ? "Today's Progress"
                    : isWeekly == 2
                        ? "Week's Progress"
                        : "Month's Progress",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Expanded(child: Container()),
              Text(
                context.watch<TodayProgressState>().inProgressBeat?.beatName ??
                    "",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 3)
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Countup(
                      begin: 0,
                      end: context.watch<TodayProgressState>().visitText + 0.0,
                      suffix: "/${scheduledVisit.toString()} visits",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    Text(
                      successVisitText.toString() + " productive visits",
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                              spreadRadius: 3)
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: totalSaleVolume,
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                              spreadRadius: 3)
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: rewardPoints + 0.0,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "Reward Points",
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                              spreadRadius: 3)
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: todaySKUVariance + 0.0,
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
        ],
      ),
    );
  }
}
