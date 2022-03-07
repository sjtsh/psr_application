import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Services/NoOrderReasonGroupService.dart';

class NoOrderScreen extends StatelessWidget {
  const NoOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  const Expanded(
                    child: Center(
                      child: Text("No Order"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: context
                    .watch<OrderScreenManagement>()
                    .noOrderReasons
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<OrderScreenManagement>()
                                .selectedNoOrderReasonGroup = e;
                          },
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: context
                                          .watch<OrderScreenManagement>()
                                          .selectedNoOrderReasonGroup
                                          ?.id ==
                                      e.id
                                  ? Colors.green
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                e.remarks,
                                style: TextStyle(
                                    color: context
                                                .watch<OrderScreenManagement>()
                                                .selectedNoOrderReasonGroup
                                                ?.id ==
                                            e.id
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child:  TextFormField(
                  controller: context
                      .read<OrderScreenManagement>()
                      .noOrderRemarkController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.book_outlined),
                      hintText: "Remark",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black))),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!context
                    .read<OrderScreenManagement>()
                    .noOrderButtonDisabled) {
                  if (context
                          .read<OrderScreenManagement>()
                          .selectedNoOrderReasonGroup !=
                      null) {
                    context
                        .read<OrderScreenManagement>()
                        .noOrderButtonDisabled = true;
                    try {
                      bool success = await NoOrderReasonGroupService()
                          .insertNoOrder(
                              context
                                  .read<OrderScreenManagement>()
                                  .selectedNoOrderReasonGroup!
                                  .id,
                              context
                                  .read<MapManagement>()
                                  .selectedOutlet!
                                  .outletPlanId,
                          context
                              .read<OrderScreenManagement>()
                              .noOrderRemarkController.text);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Successful")));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Unsuccessful")));
                      }
                    } catch (e) {
                      print(e);
                    }

                    context
                        .read<OrderScreenManagement>()
                        .noOrderButtonDisabled = false;
                  }
                }
              },
              child: Container(
                height: 60,
                color: context
                            .watch<OrderScreenManagement>()
                            .selectedNoOrderReasonGroup ==
                        null
                    ? Colors.blueGrey
                    : Colors.green,
                child: Center(
                  child: !context
                          .watch<OrderScreenManagement>()
                          .noOrderButtonDisabled
                      ? Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        )
                      : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
