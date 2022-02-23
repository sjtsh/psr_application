import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';

import './BeatStat.dart';

class BeatHeader extends StatelessWidget {
  const BeatHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 3,
              spreadRadius: 3)
        ],
      ),
      child: SizedBox(
          height: 60,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  !context.watch()<LogInManagement>().isLoading;
                },
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
