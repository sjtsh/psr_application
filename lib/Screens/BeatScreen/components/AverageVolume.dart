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
      color: Colors.white,
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
                  children: {"W": true, "M": false}
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
                  SizedBox(width: 12,),
                  Text("AVG SALES VOLUME"),
                  Expanded(child: Container()),
                  Text(context.watch<AverageVolumeState>().dateRange),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
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
                            end: context.read<AverageVolumeState>().isWeekly
                                ? context.watch<AverageVolumeState>().weeklySaleVolume
                                : context
                                    .watch<AverageVolumeState>()
                                    .monthlySaleVolume,
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
                          )
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
                            end: context.read<AverageVolumeState>().isWeekly
                                ? context
                                        .watch<AverageVolumeState>()
                                        .weeklySKUVariance +
                                    0.0
                                : context
                                        .watch<AverageVolumeState>()
                                        .monthlySKUVariance +
                                    0.0,
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
