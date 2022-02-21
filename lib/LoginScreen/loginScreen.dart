import 'package:flutter/material.dart';
class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.settings_cell),
                labelText: "Mobile Number"
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  labelText: "Mobile Number"
              ),
            )

          ],
        ),
      ),
    );
  }
}
