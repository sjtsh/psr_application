import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Signature/signature_preview_page.dart';
import 'package:signature/signature.dart';

import '../StateManagement/ShopClosedController.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  SignatureController controller = SignatureController();

  @override
  void initState() {
    super.initState();

    controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xfff2f2f2),
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 300,
                    child: Center(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xfff2f2f2),
                          shape: BoxShape.circle,
                        ),
                        child: CameraPreview(
                            context.watch<ShopClosedController>().controller!),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, -2),
                                spreadRadius: 3,
                                blurRadius: 3)
                          ]),
                      child: Signature(
                        controller: controller,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6.0),
                        child: GestureDetector(
                          onTap: () {
                            controller.clear();
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Clear",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (controller.isNotEmpty) {
                              final signature = await exportSignature();

                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) =>
                                    SignaturePreviewPage(signature!),
                              ));

                              controller.clear();
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );
    XFile ownerImg =
        await context.watch<ShopClosedController>().controller!.takePicture();
    Uint8List? signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature;
  }
}
