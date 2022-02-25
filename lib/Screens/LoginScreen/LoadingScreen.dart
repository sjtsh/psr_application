import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/logo.svg"),
             const SizedBox(
                width: 12,
              ),
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 5,
                    color: Colors.grey,
                  ),
                  AnimatedContainer(
                    width: 150 * (context.watch<LogInManagement>().loadingAt / 100),
                    height: 5,
                    color: Colors.orange,
                    duration: const Duration(milliseconds: 200),
                  ),
                ],
              ),
             const SizedBox(
                width: 12,
              ),
              Text(context.watch<LogInManagement>().loadingText),
            ],
          ),
        ),
      ),
    );
  }
}
