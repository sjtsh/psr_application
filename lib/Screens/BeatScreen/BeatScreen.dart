import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeatScreen extends StatelessWidget {
  const BeatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 60,
          color: Colors.blue,
        ),
        Expanded(
          child: Column(
            children: []
                .map((e) => Container(
                      height: 60,
                    ))
                .toList(),
          ),
        ),
        Container(
          height: 60,
          child: Column(),
        )
      ],
    ));
  }
}
