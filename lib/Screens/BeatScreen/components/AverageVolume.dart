import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';

class AverageVolume extends StatefulWidget {
  const AverageVolume({Key? key}) : super(key: key);

  @override
  State<AverageVolume> createState() => _AverageVolumeState();
}

class _AverageVolumeState extends State<AverageVolume> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 3,
            spreadRadius: 3)
      ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xffEFEFF0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                  children: {"W": 1, "M": 2, "C": 3}
                      .entries
                      .map((e) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<AverageVolumeState>().isWeekly =
                                      e.value;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: context
                                                  .watch<AverageVolumeState>()
                                                  .isWeekly ==
                                              e.value
                                          ? Colors.white
                                          : Color(0xffEFEFF0),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(e.key),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
            child: Container(
              height: 30,
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text("AVG SALES VOLUME"),
                  Expanded(child: Container()),
                  Text(context.watch<AverageVolumeState>().dateRange),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 6,right: 12.0,bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: context.read<AverageVolumeState>().isWeekly ==
                                    1
                                ? context
                                    .watch<AverageVolumeState>()
                                    .weeklySaleVolume
                                : context.read<AverageVolumeState>().isWeekly ==
                                        2
                                    ? context
                                        .watch<AverageVolumeState>()
                                        .monthlySaleVolume
                                    : context
                                        .watch<AverageVolumeState>()
                                        .customSaleVolume,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            duration: Duration(milliseconds: 200),
                            separator: ",",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "rs",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
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
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0,
                            end: context.read<AverageVolumeState>().isWeekly ==
                                    1
                                ? context
                                        .watch<AverageVolumeState>()
                                        .weeklySKUVariance +
                                    0.0
                                : context.read<AverageVolumeState>().isWeekly ==
                                        2
                                    ? context
                                            .watch<AverageVolumeState>()
                                            .monthlySKUVariance +
                                        0.0
                                    : context
                                        .watch<AverageVolumeState>()
                                        .customSKUVariance,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            duration: Duration(milliseconds: 200),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              "sku",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )
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
