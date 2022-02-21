import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BeatHeader extends StatelessWidget {
  const BeatHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Container(),
      expanded: Slider(
        onChanged: (double value) {},
        value: 50,
        max: 100,
        min: 0,
      ),
      header: SizedBox(
        height: 60,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "SELECT YOUR BEAT!!!",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
