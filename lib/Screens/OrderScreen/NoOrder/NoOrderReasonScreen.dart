import 'package:flutter/material.dart';

class NoOrderReasonScreen extends StatelessWidget {
  const NoOrderReasonScreen({Key? key}) : super(key: key);

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
        Container(
          height: 60,
          color: Colors.green,
          child: Center(
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
