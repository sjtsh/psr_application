import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
import 'package:psr_application/StateManagement/LogIn.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: context.read<LogIn>().formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: context.read<LogIn>().mobileTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.greenAccent)),
                          prefixIcon: Icon(Icons.phone_android),
                          labelText: "Mobile Number",
                          errorText: context.watch<LogIn>().mobileErrorText,
                        ),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: context.read<LogIn>().passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.greenAccent)),
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          labelText: "Password",
                          errorText: context.watch<LogIn>().passwordErrorText),
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
                      onPressed: () {
                        bool isValidated =
                            context.read<LogIn>().validateMobileNumber();
                        if (isValidated) {
                          context.read<LogIn>().Loading();
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return BeatScreen();
                          }));
                        }
                      },
                      child: Center(
                        child: !context.watch<LogIn>().isLoading
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
