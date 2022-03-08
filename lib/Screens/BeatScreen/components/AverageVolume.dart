import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 3)
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          //   child: Container(
          //     height: 30,
          //     child: Row(
          //       children: [
          //         Container(
          //           height: 10,
          //           width: 10,
          //           decoration: BoxDecoration(
          //               color: Colors.green, shape: BoxShape.circle),
          //         ),
          //         SizedBox(
          //           width: 12,
          //         ),
          //         Text("AVG SALES VOLUME"),
          //         SizedBox(
          //           width: 12,
          //         ),
          //         context.watch<AverageVolumeState>().isWeekly != 3
          //             ? Container()
          //             : Expanded(
          //                 child: Row(
          //                   children: [
          //                     Expanded(
          //                       child: GestureDetector(
          //                         onTap: () async {
          //                           picker.showCupertinoDatePicker(
          //                             context: context,
          //                             initialDate: context
          //                                 .read<DateRangeManagement>()
          //                                 .startDate,
          //                             firstDate: NepaliDateTime(
          //                                 NepaliDateTime.now().year - 1),
          //                             lastDate: NepaliDateTime.now(),
          //                             onDateChanged: (NepaliDateTime value) {
          //                               if (NepaliDateTime.now()
          //                                   .isAfter(value)) {
          //                                 context
          //                                     .read<DateRangeManagement>()
          //                                     .setStartDate(value);
          //                               }
          //                             },
          //                           );
          //                         },
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12),
          //                             color: const Color(0xffF1F2F6),
          //                           ),
          //                           child: Center(
          //                             child: Text(context
          //                                     .watch<DateRangeManagement>()
          //                                     .startDate
          //                                     .month
          //                                     .toString()
          //                                     .padLeft(2, "0") +
          //                                 "-" +
          //                                 context
          //                                     .watch<DateRangeManagement>()
          //                                     .startDate
          //                                     .day
          //                                     .toString()
          //                                     .padLeft(2, "0")),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                     Icon(
          //                       Icons.arrow_forward_rounded,
          //                       color: Colors.black.withOpacity(0.5),
          //                     ),
          //                     Expanded(
          //                       child: GestureDetector(
          //                         onTap: () {
          //                           picker.showCupertinoDatePicker(
          //                               context: context,
          //                               initialDate: NepaliDateTime.now(),
          //                               firstDate: context
          //                                   .read<DateRangeManagement>()
          //                                   .startDate,
          //                               lastDate: NepaliDateTime.now(),
          //                               onDateChanged:
          //                                   (NepaliDateTime value) async {
          //                                 if (NepaliDateTime.now()
          //                                     .isAfter(value)) {
          //                                   context
          //                                       .read<DateRangeManagement>()
          //                                       .setEndDate(value);
          //                                   context
          //                                       .read<DateRangeManagement>()
          //                                       .isRequestDisabled = true;
          //                                   await OrderService()
          //                                       .getPerformanceDateRange(
          //                                           context
          //                                               .read<
          //                                                   DateRangeManagement>()
          //                                               .startDate
          //                                               .toString()
          //                                               .substring(0, 19),
          //                                           context
          //                                               .read<
          //                                                   DateRangeManagement>()
          //                                               .endDate
          //                                               .toString()
          //                                               .substring(0, 19),
          //                                           context);
          //
          //                                   context
          //                                       .read<DateRangeManagement>()
          //                                       .isRequestDisabled = false;
          //                                 }
          //                               });
          //                         },
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(12),
          //                             color: const Color(0xffF1F2F6),
          //                           ),
          //                           child: Center(
          //                             child: Text(
          //                               context
          //                                       .watch<DateRangeManagement>()
          //                                       .endDate
          //                                       .month
          //                                       .toString()
          //                                       .padLeft(2, "0") +
          //                                   "-" +
          //                                   context
          //                                       .watch<DateRangeManagement>()
          //                                       .endDate
          //                                       .day
          //                                       .toString()
          //                                       .padLeft(2, "0"),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //       ],
          //     ),
          //   ),
          // ),
          context.read<AverageVolumeState>().isWeekly == 1
              ? TodayProgress(
    context.watch<AverageVolumeState>().isWeekly,
                  context.watch<AverageVolumeState>().todaySKUVariance,
                  context.watch<TodayProgressState>().stdQuantitySales,
                  context.watch<AverageVolumeState>().todaySaleVolume,
                  context.watch<TodayProgressState>().successVisitText,
                  context.watch<TodayProgressState>().scheduleVisit)
              : context.read<AverageVolumeState>().isWeekly == 2
                  ? TodayProgress(context.watch<AverageVolumeState>().isWeekly,
                      context.watch<AverageVolumeState>().weeklySKUVariance,
                      context.watch<TodayProgressState>().stdQuantitySales,
                      context.watch<AverageVolumeState>().weeklySaleVolume,
                      context.watch<TodayProgressState>().successVisitText,
                      context.watch<TodayProgressState>().scheduleVisit)
                  : context.read<AverageVolumeState>().isWeekly == 3
                      ? TodayProgress(context.watch<AverageVolumeState>().isWeekly,
                          context.watch<AverageVolumeState>().monthlySKUVariance,
                          context.watch<TodayProgressState>().stdQuantitySales,
                          context.watch<AverageVolumeState>().monthlySaleVolume,
                          context.watch<TodayProgressState>().successVisitText,
                          context.watch<TodayProgressState>().scheduleVisit)
                      : Container(),
        ],
      ),
    );
  }
}
