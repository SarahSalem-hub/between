//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePageWidget extends StatefulWidget {
  //const HomePageWidget({ Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final storedData = GetStorage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(
          'Between',
          style: GoogleFonts.getFont(
            'Dancing Script',
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                //color: Colors.red,
                margin: EdgeInsets.only(top:1),
                //color: Colors.red,
                child: SvgPicture.asset(
                  'assets/images/white_logo3.svg',
                  width: 90,
                  //height: 200,

                  fit: BoxFit.contain,
                ),
              )
            ),
          ),
        ],
        centerTitle: true,
        elevation: 7,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      drawer: Container(
        width: 100,
        child: Drawer(
          elevation: 16,
        ),
      ),
      body: Center(child: RoundedButton(
        onPressed:(){
          Get.toNamed("/insert_item");
        },
        title: "Orders"),

      ),
    );
  }
}
