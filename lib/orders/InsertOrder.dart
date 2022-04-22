//complete an order page

import 'dart:developer';
import 'package:between/orders/InsertItem.dart';
import 'package:between/orders/orderConnection/db_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class insertOrder extends StatefulWidget {
  // const insertOrder({Key? key}) : super(key: key);

  @override
  _insertOrderState createState() => _insertOrderState();
}

class _insertOrderState extends State<insertOrder> {
  final data = Get.arguments[0];
  final date = Get.arguments[1] as List;
  final formKey = GlobalKey<FormState>();
  var list;
  CollectionReference dbCollection =
  FirebaseFirestore.instance.collection("Days");
  String? chosen ;
  var fetch;
  late List listAfterFetching =[];


  List fetchedData = [];
  Future<List> Fetch() async{
  DocumentSnapshot documentSnapshot = await
  FirebaseFirestore.instance.collection("Days").doc().get();
  //await dbCollection.get();
  fetchedData = documentSnapshot["Value"];
  return fetchedData;
  }


  @override
  Widget build(BuildContext context) {
    Widget itemCard = Flexible(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                  elevation: 5,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    ListTile(
                      title: Text(data[index]['item'][0].toString()),
                      subtitle: Text(data[index]['item'][2].toString()),
                      trailing: Text(data[index]['item'][1].toString()),
                    )
                  ]));
            }));
    Widget orderForm = Card(

        //color: Colors.yellow,
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(

              decoration:  InputDecoration(
                hintText: 'Enter Location',
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.black,),),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.black, width: 2.0),),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.black, width: 2.0),),
                 ),

                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration:  InputDecoration(
                    hintText: 'Enter Note',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.black,),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Order time ",style: TextStyle(fontSize: 18),),
                    SizedBox(width: 100,),

                     Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(30) ,
                          dropdownColor: Colors.white60,

                          hint: Text("date"),
                          value: chosen,
                          items: date.map(( document)  {
                            log(date.runtimeType.toString());
                            return DropdownMenuItem<String>(
                              value: document["name"].toString() ,

                              child: Text(
                                document["name"].toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (valueitem) {
                            setState(() {
                              chosen = valueitem!;
                            });
                          },
                        ),
                      )

                    )
                  ],
                ),
                SizedBox(height: 14,),

                Container(
                  color: Colors.red,
                  width: 400,
                  height: 40,
                      child: RaisedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                Fluttertoast.showToast(msg: "ahhaah");
                                DbItem().addItem();

                                list = DbItem().Order();

                                log("list is :");
                                log(list.toString());
                                if (await list == null) {
                                  Fluttertoast.showToast(msg: "sth not good ");
                                  //log("list is :"+list);

                                } else {
                                  Fluttertoast.showToast(msg: "sth good");
                                  // log("list is :"+list);
                                  Fluttertoast.showToast(msg: "reached");
                                  // Fluttertoast.showToast(msg: list.length.toString());
                                  //Fluttertoast.showToast(msg: list[0].toString());
                                }
                                //DbHelper().addOrder(list);
                                // Fluttertoast.showToast(msg: list.toString());

                              }
                            },
                            child: Text("Send Order"),
                            textColor: Colors.white,
                            color: Colors.black,
                          )

                  ),

              ],
            ),
          ),
        ));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Complete an order",style: TextStyle(color: Colors.white),),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              orderForm,
              SizedBox(height: 20),
              itemCard,
            ],
          ),
        )));
  }
}
