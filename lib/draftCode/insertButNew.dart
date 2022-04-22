import 'dart:convert';
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

class insertButNew extends StatefulWidget {
  const insertButNew({Key? key}) : super(key: key);

  @override
  _insertButNewState createState() => _insertButNewState();
}

class _insertButNewState extends State<insertButNew> {
  TextEditingController OrderName = TextEditingController();
  TextEditingController OrderDes = TextEditingController();
  TextEditingController OrderEndDate = TextEditingController();

  CollectionReference dbCollection =
  FirebaseFirestore.instance.collection("orders");
  late int _count;
  late String _result;
  late List<Map<String, dynamic>> _values;

  @override
  void initState() {
    super.initState();
    _count = 0;
    _result = ' ';
    _values= [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:<Widget> [
            Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.all(),
                child: const Text(
                  'Insert Order',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                )),
            Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  //color: Colors.blue,
                  child:
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _count,
                          itemBuilder: (context,index)
                          {
                            return _row(index);
                          }
                      )
                    ,

                )
            ),
            SizedBox(height: 20,),
            Text(_result),

            Container(
              padding: EdgeInsets.all(30),
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
  _row(int key) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red)
      ),

      child: Row(
        children: [
          Text("ID:$key"),
          SizedBox(width: 30.0,),
          Expanded(child:
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red)
            ),

            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (val){
                      _onUpdate(key,val);
                    },
                    controller: OrderName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Order Name"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (val){
                      _onUpdate(key,val);
                    },
                    controller: OrderDes,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Order Description"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (val){
                      _onUpdate(key,val);
                    },
                    controller: OrderEndDate,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Order End Date"),
                  ),
                )
              ],
            ),
          )
          )
        ],
      ),
    );
  }

  _onUpdate(int key , String val){
    int foundkey = -1;
    for(var v in _values )
    {
      if(v.containsKey('id')){
        if(v['id'] == key)
        {
          foundkey = key;
          break;
        }
      }
    }
    if (-1 != foundkey)
    {
      _values.removeWhere((v) { return v['id'] == foundkey;});
    }

    Map<String, dynamic> json = {"id":key ,"value":val};
    _values.add(json);
    setState(() {
       _result= _pretty(_values);

    });
    //print(_values.toString());
  }

  String _pretty(jsonObject){
    var encoder= JsonEncoder.withIndent("    ");
    return encoder.convert(jsonObject);
  }
  }






