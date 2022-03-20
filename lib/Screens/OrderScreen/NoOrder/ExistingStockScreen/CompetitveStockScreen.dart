import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../StateManagement/NoOrderManagement.dart';
import '../../../../apis/Entities/SubGroup.dart';

class CompetitiveStockScreen extends StatefulWidget {
  final SubGroup subGroup;

  CompetitiveStockScreen(this.subGroup);

  @override
  State<CompetitiveStockScreen> createState() => _CompetitiveStockScreenState();
}

class _CompetitiveStockScreenState extends State<CompetitiveStockScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = context
        .read<NoOrderManagement>()
        .noOrderTextFieldTextCompetitiveStock ?? "";
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
                      child: Text("Competitive Screen"),
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
                      context
                          .read<NoOrderManagement>()
                          .noOrderTextFieldTextCompetitiveStock = input;
                    },
                    decoration: InputDecoration(
                        hintText: "Name of competition",
                        labelText: "Name of competition",
                        labelStyle: TextStyle(color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blueAccent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey))),
                    maxLines: null,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context
                    .read<NoOrderManagement>()
                    .addNoOrderCompetitiveExistingStock(widget.subGroup, context);
              },
              child: Container(
                height: 60,
                color: context
                    .watch<NoOrderManagement>()
                    .noOrderTextFieldTextCompetitiveStock ==
                    "" ||
                    context
                        .watch<NoOrderManagement>()
                        .noOrderTextFieldTextCompetitiveStock ==
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
            ),
          ],
        ),
      ),
    );
  }
}
