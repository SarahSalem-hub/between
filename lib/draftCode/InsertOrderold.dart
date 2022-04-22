import 'dart:math';

import 'package:between/orders/orderConnection/db_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

class insertOrderold extends StatefulWidget {
  const insertOrderold({Key? key}) : super(key: key);

  @override
  _insertOrderoldState createState() => _insertOrderoldState();
}

class _insertOrderoldState extends State<insertOrderold> {
  TextEditingController OrderName = TextEditingController();
  TextEditingController OrderDes = TextEditingController();
  TextEditingController OrderEndDate = TextEditingController();

  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection("orders");
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50),
                child: const Text(
                  'Insert Order',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                )),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: OrderName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Order Name"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: OrderDes,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Order Description"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: OrderEndDate,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Order End Date"),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    onPressed: () {
                      // DbHelper().addorder(
                      //     orderName: OrderName.text,
                      //     Des: OrderDes.text,
                      //     EndDate: OrderEndDate.text,
                      //     DocID: dbCollection
                      //         .doc("order")
                      //         .collection("item")
                      //         .doc()
                      //         .id);
                      Fluttertoast.showToast(
                          msg: dbCollection
                              .doc("order")
                              .collection("item")
                              .doc()
                              .id
                              .toString());
                      OrderDes.clear();
                      OrderName.clear();
                      OrderEndDate.clear();
                    },
                    title: "Save Order ",
                  ),
                  RoundedButton(
                    onPressed: () async {
                      setState(() {
                        _count++;
                      });
                      Fluttertoast.showToast(msg: _count.toString());
                    },
                    title: "+ ",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _row() {
    return Row(
      children: [
        //TextFormField(),
        Text("hhh")
      ],
    );
  }
}

// Container(
// alignment: Alignment.center,
// padding: EdgeInsets.all(50),
// child:  const Text(
// 'Insert Order',
// style: TextStyle(
// color: Colors.blue,
// fontWeight: FontWeight.w500,
// fontSize: 30,
//
// ),
//
// )),
// Container(
// padding: EdgeInsets.all(20),
//
// child: TextField(
// controller: OrderName,
// decoration: const InputDecoration(
// border: OutlineInputBorder(),
// labelText: "Order Name"
// ),
// ),
// ),
// Container(
// padding: EdgeInsets.all(20),
//
// child: TextField(
// controller: OrderDes,
// decoration: const InputDecoration(
// border: OutlineInputBorder(),
// labelText: "Order Description"
// ),
// ),
// ),
// Container(
// padding: EdgeInsets.all(20),
//
// child: TextField(
// controller: OrderEndDate,
// decoration: const InputDecoration(
// border: OutlineInputBorder(),
// labelText: "Order End Date"
// ),
// ),
// ),

// ..............
//

// Container(
// color: Colors.red,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// RoundedButton(
// onPressed: (){
// DbHelper().addorder(
// orderName: OrderName.text,
// Des: OrderDes.text,
// EndDate: OrderEndDate.text,
// DocID: dbCollection.doc("order").collection("item").doc().id
// );
// Fluttertoast.showToast(msg:
// dbCollection.doc("order").collection("item").doc().id.toString()
// );
// OrderDes.clear();
// OrderName.clear();
// OrderEndDate.clear();
// },
// title: "Save Order ",
//
// ),
// RoundedButton(
// onPressed: () async{
// setState(() {
// _count++;
// });
// Fluttertoast.showToast(msg: _count.toString());
// },
// title: "+ ",
//
// ),
// ],
// ),
// ),

///////

// child: Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
//
// children: [
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
// children: [
// Flexible(
// child: ListView.builder(
// shrinkWrap: true,
// itemCount: _count,
// itemBuilder: (context, index) {
// return _row();
// })),
//
// ],
// ),
// ]
// ),
// ),





