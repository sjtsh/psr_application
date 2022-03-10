import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/StateManagement/TodayProgress.dart';

class MapHeader extends StatelessWidget {
  final Function page;

  MapHeader(this.page);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1))
            ]),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                page(0);
              },
            ),
            Expanded(
              child: Text(
                context.read<TodayProgressState>().inProgressBeat?.beatName ??
                    "",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                page(0);
              },
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
