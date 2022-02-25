import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/TodayProgress.dart';

class MapHeader extends StatelessWidget {
  const MapHeader({Key? key}) : super(key: key);

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
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1))
            ]),
        child: Row(
          children: [
            SizedBox(
              width: 12,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Text(
                context.read<TodayProgressState>().inProgressBeat?.name ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
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
