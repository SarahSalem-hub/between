import 'dart:async';

import 'package:between/User/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'orders/fetchOrders.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3),() {
      var user = FirebaseAuth.instance.currentUser;
     // String userid = user!.uid;
      print(user);
      if ( user == null)
        {
          print("yes");
          Get.toNamed("/login_up");
        }
      else
        {

          Get.toNamed("/page1Home",arguments: {"userId":user.uid,"userEmail":user.email});
        }
    }
    );
  }
  final storedData = GetStorage();


  @override
  Widget build(BuildContext context) {


   // Next();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [




           const Text("Hello", style: TextStyle(fontSize: 30) ,),
            const SizedBox(height: 40,),
            Image.asset("assets/images/Black_Logo.png",
            width: 70,
            height: 70,),
            const SizedBox(height: 50),
            const SpinKitThreeBounce(
              color: Colors.black,size: 16,
            ),

          ],
        ),

      ),
    );
  }
  Next () {
    Timer(const Duration(seconds: 3),() {



      StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("yes");
            } else {
              return Text("no");
            }
          }
      );
    }
    );

}
}

