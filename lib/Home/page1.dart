import 'package:between/Home//OrdersPage.dart';
import 'package:between/mainScreen.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:between/orders/fetchOrders.dart' as fetch;

import '../User/db_user.dart';
import '../orders/fetchOrders.dart';
import 'notifiction.dart';





//في هذه الدالة يوجد بها العروض التي تكون في الصفحة الرئيسية على شكل عرض شرائح ويوجد به الازرار التي بها تنقلنا للصفحة العروض و صفحة الطلبات
class Page1 extends StatelessWidget {
  String title="Between";
  var uidDrawer =  Get.arguments["userId"];
  var uEmailDrawer =  Get.arguments["userEmail"];
  CollectionReference userProfile = FirebaseFirestore.instance.collection("Users");
var username ="";
  CollectionReference orderCollection = FirebaseFirestore.instance
      .collection("order")
      .doc("ordersGroup")
      .collection("SingleOrder");
  CollectionReference itemCollection = FirebaseFirestore.instance
      .collection("items")
      .doc("itemsGroup")
      .collection("Singleitems");
  var  storedItemIds = [];
  List returnValue =[];


  @override
  Widget build(BuildContext context) => Scaffold(

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
    drawer:(( uEmailDrawer == null ) && (uidDrawer == null) )
      ? Drawer(child: UserAccountsDrawerHeader(accountName: Text("sdgs"), accountEmail: Text("sdgs")))
      : Drawer(

      child: ListView(
        children: [

          StreamBuilder(
              stream: userProfile.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return !snapshot.hasData
                    ? Text("loading ..")
                    : Column(
                  children: [
                    ...snapshot.data!.docs.where((element) => element["Uid"]== uidDrawer ).map((e)
                    {
                      username = e["UserName"];
                      return UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                        ),
                        currentAccountPicture: FutureBuilder(
                          future: downloadURLExample(e["ProfilePath"]),
                          builder: (context,snapshot){
                            return snapshot.hasData
                                ? CircleAvatar(

                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(snapshot.data.toString()),)
                                : CircleAvatar(backgroundColor: Colors.grey);
                          },
                        ),
                        accountName:Text(e["UserName"]) ,accountEmail: Text(uEmailDrawer),
                      );
                    }
                    )],
                );

              }),


          ListTile(
            leading: Icon(Icons.info),
            title: Text("About us"),

          ),

          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
            onTap: (){
              db_user().logOut();
              Get.toNamed("/login_up");
              print(FirebaseAuth.instance.currentUser);
            },
          ),
          ElevatedButton(
              onPressed: (){
                db_user().logOut();
                Get.toNamed("/login_up");
                print(FirebaseAuth.instance.currentUser);
              }, child: Text("log out "))
        ],
      ),
    ),

    body:SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.only(top: 40,left: 30,bottom: 20),
              child: Text("Welcome,$username !",style: TextStyle(fontSize:20 ),),
            ),

            Container(
              child:  StreamBuilder(
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
            )
          ],
        ),
      ),
    )


  );

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
}

