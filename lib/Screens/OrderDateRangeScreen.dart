import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/apis/Services/OrderService.dart';

import '../Skeletons/OrdersSkeleton.dart';
import '../StateManagement/BeatManagement.dart';
import '../StateManagement/DateRangeManagement.dart';
import '../database.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

import 'OrderScreen/SingularOrder.dart';

class OrderDateRangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffF1F2F6),
          body: Column(
            children: [
              Container(
                height: 60,
                color: const Color(0xffF1F2F6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                    Expanded(child: Center(child: Text("Select start date"))),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.1)))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 120,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await picker
                                        .showMaterialDatePicker(
                                      context: context,
                                      initialDate: context
                                          .read<DateRangeManagement>()
                                          .startDate,
                                      firstDate: NepaliDateTime(
                                          NepaliDateTime.now().year),
                                      lastDate: NepaliDateTime.now(),
                                      initialDatePickerMode: DatePickerMode.day,
                                    )
                                        .then((value) {
                                      context
                                          .read<DateRangeManagement>()
                                          .setStartDate(value ??
                                              context
                                                  .read<DateRangeManagement>()
                                                  .startDate);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffF1F2F6),
                                    ),
                                    child: Center(
                                      child: Text(context
                                              .watch<DateRangeManagement>()
                                              .startDate
                                              .month
                                              .toString()
                                              .padLeft(2, "0") +
                                          "-" +
                                          context
                                              .watch<DateRangeManagement>()
                                              .startDate
                                              .day
                                              .toString()
                                              .padLeft(2, "0")),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await picker
                                        .showMaterialDatePicker(
                                      context: context,
                                      initialDate: context
                                          .read<DateRangeManagement>()
                                          .endDate,
                                      firstDate: context
                                          .read<DateRangeManagement>()
                                          .startDate,
                                      lastDate: NepaliDateTime.now(),
                                      initialDatePickerMode: DatePickerMode.day,
                                    )
                                        .then((value) {
                                      context
                                          .read<DateRangeManagement>()
                                          .setEndDate(value ??
                                              context
                                                  .read<DateRangeManagement>()
                                                  .endDate);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffF1F2F6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        context
                                                .watch<DateRangeManagement>()
                                                .endDate
                                                .month
                                                .toString()
                                                .padLeft(2, "0") +
                                            "-" +
                                            context
                                                .watch<DateRangeManagement>()
                                                .endDate
                                                .day
                                                .toString()
                                                .padLeft(2, "0"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: GestureDetector(
                              onTap: () async {
                                if (!context
                                    .read<DateRangeManagement>()
                                    .isRequestDisabled) {
                                  context
                                      .read<DateRangeManagement>()
                                      .isRequestDisabled = true;
                                  try {
                                    await OrderService().getOrdersDateRange(
                                        context
                                            .read<DateRangeManagement>()
                                            .startDate
                                            .toString()
                                            .substring(0, 19),
                                        context
                                            .read<DateRangeManagement>()
                                            .endDate
                                            .toString()
                                            .substring(0, 19),
                                        context);
                                  } catch (e) {
                                    print(e);
                                  }
                                  context
                                      .read<DateRangeManagement>()
                                      .isRequestDisabled = false;
                                }
                              },
                              child: Container(
                                color: Colors.green,
                                child: Center(
                                  child: context
                                          .watch<DateRangeManagement>()
                                          .isRequestDisabled
                                      ? SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                          )))
                                      : Text(
                                          "Request",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: context.watch<DateRangeManagement>().isRequestDisabled
                    ? OrdersSkeleton()
                    : context.watch<DateRangeManagement>().requestedOrders !=
                            null
                        ? (context
                                        .watch<DateRangeManagement>()
                                        .requestedOrders ??
                                    [])
                                .isEmpty
                            ? Center(child: Text("No Orders Found"))
                            : ListView(
                                children: (context
                                            .watch<DateRangeManagement>()
                                            .requestedOrders?.reversed ??
                                        [])
                                    .map(
                                      (e) => SingularOrder(e),
                                    )
                                    .toList())
                        : ListView(
                            children: context
                                .watch<BeatManagement>()
                                .outletOrders.reversed
                                .map(
                                  (e) => SingularOrder(e),
                                )
                                .toList()),
              ),
            ],
          )),
    );
  }
}
