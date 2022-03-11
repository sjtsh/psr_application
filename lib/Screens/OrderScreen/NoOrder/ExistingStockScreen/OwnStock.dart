import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../StateManagement/NoOrderManagement.dart';
import '../../../../StateManagement/ShopClosedController.dart';
import '../NoOrderCamera.dart';

class OwnStock extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: double.infinity,
            height: 60,
            child: TextField(
            onChanged: (input){
              context
                  .read<NoOrderManagement>()
                  .noOrderTextFieldTextOwnStock = input;
            },
              decoration: InputDecoration(
                  hintText: "Stock Count",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.green)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return NoOrderCamera();
              }));
            },
            child: Container(
              height: 60,
              color: Colors.green,
              child: Center(
                child: Text(
                  context.watch<ShopClosedController>().noOrderPhotoLocalUrl ==
                          null
                      ? "Click a photo"
                      : "Retake",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                image: (context
                            .watch<ShopClosedController>()
                            .noOrderPhotoLocalUrl ==
                        null)
                    ? null
                    : DecorationImage(
                        image: FileImage(
                          File(context
                              .watch<ShopClosedController>()
                              .noOrderPhotoLocalUrl!),
                        ),
                      ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            color: context.watch<ShopClosedController>().noOrderPhotoLocalUrl ==
                        null ||
                    int.tryParse(context
                                .watch<NoOrderManagement>()
                                .noOrderTextFieldTextOwnStock ??
                            "") ==
                        null
                ? Colors.blueGrey
                : Colors.green,
            child: Center(
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
