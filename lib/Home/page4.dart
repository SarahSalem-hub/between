import 'package:between/Home/UserInformation.dart';
import 'package:flutter/material.dart';





const url="https://meshivanshsingh.me";
const email="Davidwatson5546@icloud.com";
const phone="+967773954360";
const location="Sana'a, Yemen";
const password="Software*690";

String title="Between";

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
        centerTitle: true,
        actions: <Widget>[

          IconButton(icon: Icon(Icons.search), onPressed:null,),
          IconButton(icon: Icon(Icons.settings,color: Colors.white,), onPressed:null,),

        ],

        elevation: 0.0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children:<Widget> [

              CircleAvatar(

                radius: 90,
                backgroundImage: AssetImage('images/R.jpg'),
              ),
              Text("David Watson",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),



              InfoUser(textt: email, icon: Icons.mail_outline, onPressedd:()async {}),
              InfoUser(textt: password, icon: Icons.lock_outline, onPressedd:()async {}),
              InfoUser(textt: phone, icon: Icons.phone, onPressedd:()async {}),
              InfoUser(textt: url, icon: Icons.web, onPressedd:()async {}),
              InfoUser(textt: location, icon: Icons.location_city, onPressedd:()async {}),
            ],
          ),
        ),
      ),

    );
  }
}
