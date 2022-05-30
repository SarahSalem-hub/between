//complete an order page

import 'dart:developer';
import 'package:between/orders/InsertItem.dart';
import 'package:between/orders/orderConnection/db_item.dart';
import 'package:between/orders/orderConnection/db_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class insertOrder extends StatefulWidget {
  // const insertOrder({Key? key}) : super(key: key);

  @override
  _insertOrderState createState() => _insertOrderState();
}

class _insertOrderState extends State<insertOrder> {
  final data = Get.arguments[0];
  //final date = Get.arguments[1] as List;
  final formKey = GlobalKey<FormState>();




  TextEditingController location = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController orderName = TextEditingController();
  var date = DateTime.now().add(new Duration(days: 2)) ;
  final user = FirebaseAuth.instance.currentUser!;

////////////////////guess not important
  List fetchedData = [];
  Future<List> Fetch() async{
  DocumentSnapshot documentSnapshot = await
  FirebaseFirestore.instance.collection("Days").doc().get();
  //await dbCollection.get();
  fetchedData = documentSnapshot["Value"];
  return fetchedData;
  }
////////////////
  var  list;

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
                  controller: orderName,
                  decoration:  InputDecoration(
                    hintText: 'Enter Order Name',
                    icon: FaIcon(FontAwesomeIcons.pen,color: Colors.black,),
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
                  controller: location,
              decoration:  InputDecoration(
                hintText: 'Enter Location',
                icon: FaIcon(FontAwesomeIcons.mapMarkerAlt,color: Colors.black,),
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
                  controller: note,
                  decoration:  InputDecoration(
                    hintText: 'Enter Note',
                    icon: FaIcon(FontAwesomeIcons.stickyNote,color: Colors.black,),
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
                // Row(
                //   children: const [
                //
                //     // Text("Order time ",style: TextStyle(fontSize: 18),),
                //     SizedBox(width: 100,),
                //   ]
                // ),


                DateTimeFormField(
                  decoration:  InputDecoration(
                    hintText: 'Select Date ..',
                    icon: FaIcon(FontAwesomeIcons.calendar,color: Colors.black,),
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
                  mode: DateTimeFieldPickerMode.date,
                  //autovalidateMode: AutovalidateMode.always,
                  onDateSelected: (DateTime value) {
                    print(value.runtimeType.toString()) ;
                    date = value;
                  },

                ),
                SizedBox(height: 20,),
                Container(
                  color: Colors.red,
                  width: 400,
                  height: 40,
                      child: RaisedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                list =  await DbItem().addItem(user.uid,orderName.text,location.text, note.text, date);

                                showDialog(
                                   context: context,
                                   builder:(context)=> AlertDialog(
                                     content: CircularProgressIndicator(),
                                   ));


                                if(list != null)
                                  {

                                    print("sdgsdg");
                                    Get.toNamed("/home");
                                  }
                                print("list");
                                print(list);

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
          title: Text(user.uid,style: TextStyle(color: Colors.white),),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              orderForm,
              SizedBox(height: 4),
              itemCard,

            ],
          ),
        )));
  }
}
