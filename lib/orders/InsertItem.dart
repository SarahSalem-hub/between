import 'dart:convert';
import 'dart:developer';

import 'package:between/orders/DynamicItem.dart';
import 'package:between/orders/WidgetControllers.dart';
import 'package:between/orders/orderConnection/db_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class insertItem extends StatefulWidget {
  // const insertItem({Key? key}) : super(key: key);

  @override
  _insertItemState createState() => _insertItemState();
  // DynamicItem DI = DynamicItem();
  // WidgetControllers Wc =WidgetControllers();
}

class _insertItemState extends State<insertItem> {
  List<DynamicItem> DynamicList = [];
  List<String> data = [];
  late var doc  ;
  late List list = [];
  int index = 0;
  String instruction = " press \" + \" to \n add a new item";
  Icon floatingIcon = new Icon(Icons.add);

  addDynamic() {
    FocusScope.of(context).unfocus();
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);

      data = [];
      DynamicList = [];
    }
    setState(() {});
    if (DynamicList.length >= 5) {
      return;
    }

    if (DynamicList.isEmpty) {
      instruction ="";
      DynamicList.add(new DynamicItem());
    } else {
      String InputValid = WidgetControllers().dataMaker(DynamicList, data)[0];
      if (InputValid == "true") {
        // print ("data is empty");
        DynamicList.add(new DynamicItem());
      } else
        Fluttertoast.showToast(msg: "complete the last Item");
    }
  }

  submitList() {
    floatingIcon = new Icon(Icons.arrow_back);
    data = [];
    setState(() {});
    // var map = data.asMap();
  }

  // List fetchedData =[] ;
  // Future<String> Fetch() async{
  //   CollectionReference documentSnapshot =
  //   FirebaseFirestore.instance.collection("Days");
  //   //await dbCollection.get();
  //   documentSnapshot.doc().get().then((querySnapshot){
  //     print(querySnapshot["Value"]);
  //     return querySnapshot["Value"];
  //     });
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Stack(
       // flex: 2,
       children:[ Container(
          //color: Colors.red,
          child: ListView.builder(
            itemCount: DynamicList.length,
            itemBuilder: (context, index) => DynamicList[index],
          ),
        )]);

    Widget submitBtn = Container(
      color: Colors.red,
      child: RaisedButton(
        onPressed: submitList,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Submit'),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("New Order" ,style: TextStyle(color: Colors.white),),
        //automaticallyImplyLeading: false,
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 15.5, right: 20),
              child: GestureDetector(
                  onTap: ()  {
                    //DbHelper().addOrder(WidgetControllers().dataMaker(DynamicList, data)[2]);
                    Fluttertoast.showToast(msg: "next");


                    // CollectionReference documentSnapshot =
                    // FirebaseFirestore.instance.collection("Days");
                    // QuerySnapshot  querySnapshot = await documentSnapshot.orderBy("Value").get();
                    //
                    // //await dbCollection.get();
                    // list.clear();
                    //
                    //  querySnapshot.docs.map((DocumentSnapshot e)
                    //     {
                    //       //doc.add(e.data() as Map<String,dynamic>);
                    //       //print(e.data() as Map<String,dynamic>);
                    //       // print(e["Value"] );
                    //
                    //       Map<String, dynamic> map = {
                    //         'name': e["Name"],
                    //         'value' :e["Value"]
                    //
                    //       };
                    //       list.add(map);
                    //       //print ();
                    //        //e.data;
                    //       //var a = e.data();
                    //       //doc.add(Map<String, dynamic>.from(a) );
                    //       // print(e.data().toString());
                    //       // print(e.data().runtimeType.toString());
                    //     }
                    //     ).toList();
                    //
                    // print(list);



                    // documentSnapshot..then((querySnapshot){
                    //   print(querySnapshot["Value"]);
                    //   return querySnapshot["Value"];
                    // });

                    // print("arg: "+WidgetControllers().dataMaker(DynamicList, data )[1].toString());
                    Get.toNamed("/insert_order",
                        arguments:[ WidgetControllers()
                            .dataMaker(DynamicList, data)[2],list]);

                    // print("arg: "+WidgetControllers().ItemID.length.toString());
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Next",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 20, left: 5),
                              child: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.arrowCircleRight,
                                  size: 20,
                                ),
                              )),
                        ],
                      )
                    ],
                  ))),
        ],
      ),
      body: Container(

        color: Colors.white,
        child: Container(

          margin: EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Center(
                child: Text(instruction),
              ),
              dynamicTextField,
            ],
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(backgroundColor:Colors.black,onPressed: addDynamic, child: floatingIcon),
    );
  }
}
