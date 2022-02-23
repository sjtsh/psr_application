import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';
import 'package:psr_application/database.dart';

import './BeatStat.dart';

class BeatHeader extends StatelessWidget {
  const BeatHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF1F2F6),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 3,
              spreadRadius: 3)
        ],
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color(0xff797979), shape: BoxShape.circle),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meUser!.name),
                Text(
                  "Sales Supervisor",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Expanded(child: Container()),
            Icon(
              Icons.calendar_today,
              color: Colors.blue,
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
