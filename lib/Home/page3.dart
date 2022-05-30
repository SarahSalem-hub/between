import 'package:flutter/material.dart';
//import 'package:open_whatsapp/open_whatsapp.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: Colors.green,
          onPressed: (){
            //FlutterOpenWhatsapp.sendSingleMessage("+967733761643", "How Can I Help You ?");
          },
          child: Container(
            width: 160,
            child: Row(
              children: [
                Icon(Icons.whatsapp,color: Colors.white),
                SizedBox(width: 10),
                Text("WhatsApp",style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


