import 'package:flutter/material.dart';
import 'package:psr_application/Screens/BeatScreen/components/IndividualBeat.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

         Padding(
           padding: EdgeInsets.only(top: 30, left: 12),
           child: Text("Order", style: TextStyle(fontSize:36, fontWeight: FontWeight.normal),),
         ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                 hintText: "Search",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.green)) ,
                enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.black))),
                onFieldSubmitted: (text){
                  print(text);
                },
               style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      )
    );
  }
}



