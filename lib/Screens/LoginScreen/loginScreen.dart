import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:psr_application/StateManagement/LogInManagement.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: context.read<LogInManagement>().formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: context.read<LogInManagement>().mobileTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.greenAccent)),
                          prefixIcon: Icon(Icons.phone_android),
                          labelText: "Mobile Number",
                          errorText: context.watch<LogInManagement>().mobileErrorText,
                        ),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: context.read<LogInManagement>().passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.greenAccent)),
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          labelText: "Password",
                          errorText: context.watch<LogInManagement>().passwordErrorText),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MaterialButton(
                      height: 50,
                      onPressed: () async {
                        bool isValidated =
                            context.read<LogInManagement>().validateMobileNumber();
                        if (isValidated) {
                          await context.read<LogInManagement>().Loading(context);
                        }
                      },
                      child: Center(
                        child: !context.watch<LogInManagement>().isLoading
                            ? const Text(
                                "Login ",
                                style: TextStyle(color: Colors.white),
                              )
                            : CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
