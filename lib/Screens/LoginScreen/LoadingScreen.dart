import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Signature/signature_page.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';

import '../BeatScreen/BeatScreen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!context.watch<LogInManagement>().isVerified){
      return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              SvgPicture.asset("assets/logo.svg"),
              const SizedBox(
                width: 12,
              ),
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 5,
                    color: Colors.red.shade200,
                  ),
                  AnimatedContainer(
                    width: 150 *
                        (context.watch<LogInManagement>().loadingAt / 100),
                    height: 5,
                    color: Colors.red,
                    duration: const Duration(milliseconds: 200),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(context.watch<LogInManagement>().loadingText),
              Expanded(child: Container()),
              Expanded(child: Container()),
            ],
          ),
        ),
      );
    }else{
      return BeatScreen();
      // return SignaturePage();
    }
  }
}
