import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/NoOrderManagement.dart';

class CompetitiveStock extends StatelessWidget {
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
                onChanged: (input) {
                  context.read<NoOrderManagement>().noOrderTextFieldTextCompetitiveStock =
                      input;
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
        Container(
          height: 60,
          color: context
                      .watch<NoOrderManagement>()
                      .noOrderTextFieldTextCompetitiveStock ==
                  "" || context
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
      ],
    );
  }
}
