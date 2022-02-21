import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mt;
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mt.Scaffold(
      body: Form(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child:CupertinoTextField(
                    decoration: BoxDecoration(),
                  ),
                ),
                SizedBox(height: 12,),
                SizedBox(
                  width: 300,
                  child:mt. TextFormField(
                    obscureText: true,
                    decoration: mt.InputDecoration(
                        border: mt.OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: mt.Colors.greenAccent)),
                        prefixIcon: Icon(mt.Icons.vpn_key_outlined),
                        labelText: "Password"
                    ),
                  ),
                ),

                SizedBox(height: 12,),
                CupertinoButton(onPressed: (){
                  Navigator.push(context, mt.MaterialPageRoute(builder: (_){
                    return BeatScreen();
                  }));

                },
                child: Container(
                  height: 50,
                  width:  150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: mt.Colors.lightBlue
                  ),
                  child: const Center(
                    child: Text(
                      "Login ", style: TextStyle(color: mt.Colors.white),
                    ),
                  ),
                ),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
