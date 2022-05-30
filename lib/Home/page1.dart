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
import 'notifiction.dart';





//في هذه الدالة يوجد بها العروض التي تكون في الصفحة الرئيسية على شكل عرض شرائح ويوجد به الازرار التي بها تنقلنا للصفحة العروض و صفحة الطلبات
class Page1 extends StatelessWidget {
  String title="Between";
  var uidDrawer =  Get.arguments["userId"];
  var uEmailDrawer =  Get.arguments["userEmail"];
  CollectionReference userProfile = FirebaseFirestore.instance.collection("Users");


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

    body:
    ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions( autoPlay: true,height: 250.0),
            items: [

            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Image.network(i),
                  );
                },
              );
            }).toList(),
          ),





          Padding(
     padding: const EdgeInsets.all(100.0),
     child: Container(
       margin: EdgeInsets.all(0),
       child:Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisAlignment: MainAxisAlignment.center,
         children:<Widget> [
          FlatButton(
            child: const Text("Orders"),
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () {
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrdersPage()
)
);
          },
          ),


  ]
       )
        ),
   )
  ]
    ),
  );

  Future<String> downloadURLExample(String imagePath) async {

    var downloadURL = await FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();

    //print(downloadURL.toString());
    return downloadURL;
  }
}

