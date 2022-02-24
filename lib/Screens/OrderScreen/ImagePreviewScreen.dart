import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/TodayProgress.dart';
import 'package:psr_application/database.dart';

import '../../apis/Services/ShopClosed.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String path;

  ImagePreviewScreen(this.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Image.file(
            File(path),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: const Text(
                        "Retry",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    OutletClosedService()
                        .insertOutletClosed(
                            File(path), "trying${path.split("\\").last}", meUser?.id ?? "0", "remarks", 1)
                        .then((value) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: const Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
