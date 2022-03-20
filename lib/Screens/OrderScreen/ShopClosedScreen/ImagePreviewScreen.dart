import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/MapManagement.dart';
import 'package:psr_application/StateManagement/ShopClosedController.dart';
import 'package:psr_application/database.dart';

import '../../../StateManagement/DataManagement.dart';
import '../../../apis/Services/ShopClosed.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String path;
  final int outletId;

  ImagePreviewScreen(this.path, this.outletId);

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
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextFormField(
            controller: context
                .read<ShopClosedController>()
                .remarkTextEditingController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.book_outlined),
                hintText: "Remark",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.green)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black))),
            onFieldSubmitted: (text) {},
            style: const TextStyle(fontWeight: FontWeight.bold),
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
                    print(outletId);
                    context.read<ShopClosedController>().imageSent();
                    OutletClosedService()
                        .insertOutletClosed(
                            File(path),
                            "trying${path.split("\\").last}",
                        context.watch<DataManagement>().hiveBox.user.id ,
                            context
                                .read<ShopClosedController>()
                                .remarkTextEditingController
                                .text,
                            outletId, context)
                        .then((value) {
                          context.read<ShopClosedController>().imageSent();
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
                      child: !context.watch<ShopClosedController>().isloading
                          ? Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
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
