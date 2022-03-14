import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../StateManagement/NoOrderManagement.dart';
import '../../../../StateManagement/ShopClosedController.dart';
import '../../../../apis/Entities/SubGroup.dart';
import '../NoOrderCamera.dart';

class OwnStock extends StatefulWidget {
  final SubGroup subGroup;
  final Function refresh;

  OwnStock(this.subGroup, this.refresh);

  @override
  State<OwnStock> createState() => _OwnStockState();
}

class _OwnStockState extends State<OwnStock> {
  final TextEditingController controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = context
        .read<NoOrderManagement>()
        .noOrderTextFieldTextOwnStock ?? "";
  }

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
            controller: controller,
              onChanged: (input) {
                context.read<NoOrderManagement>().noOrderTextFieldTextOwnStock =
                    input;
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
                  context.watch<NoOrderManagement>().noOrderPhotoLocalUrl ==
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
                            .watch<NoOrderManagement>()
                            .noOrderPhotoLocalUrl ==
                        null)
                    ? null
                    : DecorationImage(
                        image: FileImage(
                          File(context
                              .watch<NoOrderManagement>()
                              .noOrderPhotoLocalUrl!),
                        ),
                      ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context
                .read<NoOrderManagement>()
                .addNoOrderOwnExistingStock(widget.subGroup, widget.refresh, context);
          },
          child: Container(
            height: 60,
            color: context.watch<NoOrderManagement>().noOrderPhotoLocalUrl ==
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
