import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/BeatManagement.dart';

import '../../../StateManagement/LogInManagement.dart';
import 'IndividualBeat.dart';

class SelectBeat extends StatelessWidget {
  const SelectBeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Assigned Beats"),
          SizedBox(
            height: 12,
          ),
          Column(
            children: [
              ...context
                  .watch<BeatManagement>()
                  .beats
                  .where((element) => !element.isDone)
                  .map((e) => IndividualBeat(e))
                  .toList(),
              ...context
                  .watch<BeatManagement>()
                  .beats
                  .where((element) => element.isDone)
                  .map((e) => IndividualBeat(e))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
