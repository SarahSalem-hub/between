import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../Home/notifiction.dart';
import '../mainScreen.dart';

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
  String title="Between";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Fetching Orders"),
        //   backgroundColor: Colors.black,
        //   leading: new IconButton(
        //     icon: new Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: (){
        //      Get.toNamed("/home");
        //     },
        //   ),
        // ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
        centerTitle: true,
        actions: <Widget>[

          IconButton(icon: Icon(Icons.search),onPressed: (){
            showSearch(context: context, delegate: DataSearch());

            },),

        ],

        elevation: 0.0,
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
                    ? Center(child: CircularProgressIndicator())
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
            ),
             // Container(
             //   width: 200,
             //   height: 200,
             //   child: FutureBuilder(
             //     future: getDate(),
             //     builder: (context,snapshot){
             //       return snapshot.hasData
             //           ? Image.network(snapshot.data.toString())
             //           : Text("sdg");
             //     },
             //   ),
             // )
             ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed("/insert_item",
              //arguments: {"orderId":}
               );
        },
        backgroundColor: Colors.black,
        child: Text("+"),),
    );



  }

  Widget orderCard(snapshot, data) {

    DateTime dt = (data["Date"] as Timestamp).toDate();
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference userProfile = FirebaseFirestore.instance.collection("Users");
    var profilePath;
    var username;
    return InkWell(
      onTap: () {
        Get.toNamed("/single_order", arguments: {"oId": data.id,"path":profilePath.toString(),"username":username});
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          horizontalTitleGap: 16,
          leading: StreamBuilder(
            stream: userProfile.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : Column(
                children: [
                  ...snapshot.data!.docs.where((element) => element["Uid"]==data["uid"]).map((e)
              {
               // profile = imageUrl.child(e["ProfilePath"]).getDownloadURL();

                profilePath = e["ProfilePath"];
                username =  e["UserName"];
                return Container(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: downloadURLExample(e["ProfilePath"]),
                        builder: (context,snapshot){
                          return snapshot.hasData
                              ? CircleAvatar(

                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(snapshot.data.toString()),)
                            : CircleAvatar(backgroundColor: Colors.grey);
                        },
                      ),
                     // Text(e["UserName"])
                    ],
                  )
                );
                // return CircleAvatar(
                //   child: Image.network(downloadURLExample().toString(),fit: BoxFit.cover,),);
              })
                ],
              );
            },
          ), //order id
          title: Text(data["OrderName"]), //order field
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

  Future<String> downloadURLExample(String imagePath) async {

    var downloadURL = await FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();

   //print(downloadURL.toString());
   return downloadURL;
  }

  // Future<dynamic> getDate(String imagePath) async {
  //   var url;
  //   try{
  //    url = await downloadURLExample(imagePath);
  //    print(url.toString());
  //     return url;
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }
}




