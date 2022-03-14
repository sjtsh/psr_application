import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/NoOrderManagement.dart';

import '../../../../apis/Entities/SubGroup.dart';

class CompetitiveStock extends StatefulWidget {
  final SubGroup subGroup;

  CompetitiveStock(this.subGroup);

  @override
  State<CompetitiveStock> createState() => _CompetitiveStockState();
}

class _CompetitiveStockState extends State<CompetitiveStock> {
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
    return Column(
      children: [
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
    );
  }
}
