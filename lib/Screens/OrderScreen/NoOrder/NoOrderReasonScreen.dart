import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/NoOrderManagement.dart';
import 'package:psr_application/StateManagement/OrderScreenManagement.dart';
import 'package:psr_application/apis/Entities/SubGroup.dart';

class NoOrderReasonScreen extends StatefulWidget {
  final SubGroup subGroup;
  final Function refresh;

  NoOrderReasonScreen(this.subGroup, this.refresh);

  @override
  State<NoOrderReasonScreen> createState() => _NoOrderReasonScreenState();
}

class _NoOrderReasonScreenState extends State<NoOrderReasonScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = context
        .read<NoOrderManagement>()
        .noOrderReasonTextField ?? "";
  }

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
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Center(
                      child: Text("No Order Screen"),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: TextField(
                  controller: controller,
                    onChanged: (input) {
                      context.read<NoOrderManagement>().noOrderReasonTextField =
                          input;
                    },
                    decoration: InputDecoration(
                        hintText: "Reason for no order",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.green)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.black))),
                    maxLines: 100,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<NoOrderManagement>().addNoOrderReason(widget.subGroup, widget.refresh, context);
              },
              child: Container(
                height: 60,
                color: context.watch<NoOrderManagement>().noOrderReasonTextField ==
                            "" ||
                        context.watch<NoOrderManagement>().noOrderReasonTextField ==
                            null
                    ? Colors.blueGrey
                    : Colors.green,
                child: Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white),
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
