import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/LocalNoSQL/Performance.dart';
import 'package:psr_application/StateManagement/AverageVolume.dart';

import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import '../../../Skeletons/CustomVolumeSkeleton.dart';
import '../../../StateManagement/DateRangeManagement.dart';
import '../../../StateManagement/TodayProgress.dart';
import '../../../apis/Services/OrderService.dart';
import 'TodayProgress.dart';

class AverageVolume extends StatefulWidget {
  const AverageVolume({Key? key}) : super(key: key);

  @override
  State<AverageVolume> createState() => _AverageVolumeState();
}

class _AverageVolumeState extends State<AverageVolume> {
  @override
  Widget build(BuildContext context) {
    Box<dynamic>? performance = context.read<TodayProgressState>().performanceBox;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
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
              child: Builder(builder: (context) {
                double width = MediaQuery.of(context).size.width;
                return Stack(
                  children: [
                    AnimatedPositioned(
                      top: 2,
                      left: context.watch<AverageVolumeState>().isWeekly == 1
                          ? 2
                          : context.watch<AverageVolumeState>().isWeekly == 2
                              ? (width - 28) * 1 / 3
                              : (width - 28) * 2 / 3,
                      right: context.watch<AverageVolumeState>().isWeekly == 3
                          ? 2
                          : context.watch<AverageVolumeState>().isWeekly == 2
                              ? (width - 28) * 1 / 3
                              : (width - 28) * 2 / 3,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                          width: width / 3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: width / 3,
                            height: 26,
                          )),
                    ),
                    Row(
                        children: {"T": 1, "W": 2, "M": 3}
                            .entries
                            .map((e) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<AverageVolumeState>()
                                            .isWeekly = e.value;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(e.key),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
                  ],
                );
              }),
            ),
          ),
          TodayProgress(
              context.watch<AverageVolumeState>().isWeekly,
              performance!
                  .getAt(context.read<AverageVolumeState>().isWeekly - 1)!
                  .avgSKU,
              performance
                  .getAt(context.read<AverageVolumeState>().isWeekly - 1)!
                  .stdQuantitySales,
              performance
                  .getAt(context.read<AverageVolumeState>().isWeekly - 1)!
                  .netValueSales,
              performance
                  .getAt(context.read<AverageVolumeState>().isWeekly - 1)!
                  .successVisit,
              performance
                  .getAt(context.read<AverageVolumeState>().isWeekly - 1)!
                  .scheduleVisit,
              performance
                  .getAt(context.read<AverageVolumeState>().isWeekly - 1)!
                  .productiveVisit),
        ],
      ),
    );
  }
}
