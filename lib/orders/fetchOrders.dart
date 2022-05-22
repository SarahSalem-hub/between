import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class fetchOrders extends StatefulWidget {
  //const fetchOrders({Key? key}) : super(key: key);

  @override
  _fetchOrdersState createState() => _fetchOrdersState();

}


class _fetchOrdersState extends State<fetchOrders> {

  var  storedItemIds = [];
 List returnValue =[];
  CollectionReference orderCollection = FirebaseFirestore.instance
      .collection("order")
      .doc("ordersGroup")
      .collection("SingleOrder");

  CollectionReference itemCollection = FirebaseFirestore.instance
      .collection("items")
      .doc("itemsGroup")
      .collection("Singleitems");



  dynamic storingItemIds (){
    storedItemIds.clear();
    CollectionReference itemCollection = FirebaseFirestore.instance
        .collection("items")
        .doc("itemsGroup")
        .collection("Singleitems");


    itemCollection.snapshots().forEach((element) {
      element.docs.forEach((e) {

        storedItemIds.add({"id":e.id,"Name":e["title"].toString()});

      });
    });

    return storedItemIds;

  }

  @override
  void initState() {
    storingItemIds();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Fetching Orders"),
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: EdgeInsets.all(18),
          child: Stack(
             children :[


               // storingItemIds(),


               StreamBuilder(
                stream: orderCollection.snapshots(),
                builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


                return !snapshot.hasData
                    ? Text('PLease Wait')
                    : Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...snapshot.data!.docs.map((data) {
                                //print( itemsNames(data["ItemIds"]));

                                return orderCard(snapshot, data);
                              }),
                            ],
                          ),
                        ),
                      );
              },
            )],
          ),
        ));



  }

  Widget orderCard(snapshot, data) {

    DateTime dt = (data["Date"] as Timestamp).toDate();

    return InkWell(
      onTap: () {
        Get.toNamed("/single_order", arguments: {"oId": data.id});
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          horizontalTitleGap: 16,
          leading: Text(data["OrderName"].toString()), //order id
          title: Text(data["Note"]), //order field
          subtitle: Text(itemsNames(storedItemIds,data["ItemIds"]).toString()), //order items ids
          trailing:  Text(
            dt.day.toString() +
                "/" +
                dt.month.toString() +
                "/" +
                dt.year.toString(),
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }



  List itemsNames (List storedIds, List<dynamic> orderItemIds){
  returnValue.clear();

  for( int i =0 ; i< storedIds.length; i++)
  {

    for( int j =0 ; j< orderItemIds.length; j++ ) {

      if (storedIds[i]["id"] == orderItemIds[j]) {

        returnValue.add(storedIds[i]["Name"].toString());
        //print(returnValue.toString());
      }
    }
  }
  return returnValue;

}
}




