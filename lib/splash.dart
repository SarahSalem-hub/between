import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storedData = GetStorage();

  @override
  Widget build(BuildContext context) {
    Next();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

           Text("Hello",
          style: TextStyle(fontSize: 30) ,
           ),
            SizedBox(height: 40,),
            Image.asset("assets/images/Black_Logo.png",
            width: 70,
            height: 70,),
            SizedBox(height: 50),
            SpinKitThreeBounce(
              color: Colors.black,size: 16,
            ),



          ],
        ),

      ),
    );
  }
}


 Next () {
  Timer(Duration(seconds: 5), (){

         Get.offNamed("/home");
     }
  );
 }
