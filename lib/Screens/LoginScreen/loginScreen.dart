
import 'package:flutter/material.dart';
import 'package:psr_application/Screens/BeatScreen/BeatScreen.dart';
class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.greenAccent)),
                        prefixIcon: Icon(Icons.phone_android),
                        labelText: "Mobile NUmber"
                    ),
                  )
                ),
                SizedBox(height: 12,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.greenAccent)),
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        labelText: "Password"
                    ),
                  ),
                ),

                SizedBox(height: 12,),
                MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return BeatScreen();
                  }));

                },
                child: Container(
                  height: 50,
                  width:  150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.lightBlue
                  ),
                  child: const Center(
                    child: Text(
                      "Login ", style: TextStyle(color: Colors.white),
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
