//import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePageWidget extends StatefulWidget {
  const HomePageWidget({ Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xF7C4AA85),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Between',
          style: GoogleFonts.getFont(
            'Dancing Script',
            color: Color(0xF7383635),
            fontSize: 30,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: SvgPicture.asset(
                'assets/images/Between_logo.svg',
                width: 80,
                fit: BoxFit.fitHeight,
              ),
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
    );
  }
}
