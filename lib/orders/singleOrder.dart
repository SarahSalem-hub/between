import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:open_whatsapp/open_whatsapp.dart';

class singleOrder extends StatefulWidget {
  const singleOrder({Key? key}) : super(key: key);

  @override
  _singleOrderState createState() => _singleOrderState();
}

class _singleOrderState extends State<singleOrder> {

  CollectionReference orderCollection = FirebaseFirestore.instance
      .collection("order")
      .doc("ordersGroup")
      .collection("SingleOrder");

  final orderid = Get.arguments["oId"];
  final proPath = Get.arguments["path"];
  final uName = Get.arguments["username"];

  Widget singleOrder(){

    return StreamBuilder(
      stream: orderCollection.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return !snapshot.hasData
            ? Text('PLease Wait')
            : Container(
          //color: Colors.blue,
          padding: EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            children: [
              ...snapshot.data!.docs.map((data) {
                return Container(
                  //color: Colors.grey,
                    child: detailedOrdered(orderid, data.id, data));
              })
            ],
          ),
        );
      },
    );
  }

  Widget detailedOrdered(
      String id, String dataId, QueryDocumentSnapshot<Object?> data) {
    DateTime dt = (data["Date"] as Timestamp).toDate();
    var dataItemIds = data["ItemIds"].toList();
    CollectionReference itemCollection = FirebaseFirestore.instance
        .collection("items")
        .doc("itemsGroup")
        .collection("Singleitems");

    CollectionReference offerCollection = FirebaseFirestore.instance
        .collection("offers");
    final user = FirebaseAuth.instance.currentUser!;

    if (id == dataId) {
      return Container(
        child: Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 10,
                    // color: Colors.pink,
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            ListTile(
                               leading: FutureBuilder(
                                future: downloadURLExample(proPath.toString()),
                               builder: (context,snapshot){
                                return snapshot.hasData
                                    ? CircleAvatar(
                                  radius: 20,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(snapshot.data.toString()),)
                                  : CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey);
                                },
                              ),
                              title: Text(uName),
                              trailing: Text(
                                dt.day.toString() +
                                    "/" +
                                    dt.month.toString() +
                                    "/" +
                                    dt.year.toString(),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(20),
                              horizontalTitleGap: 15,
                              minLeadingWidth: 0,
                              minVerticalPadding: 10,

                              leading: const FaIcon(
                                FontAwesomeIcons.stickyNote,
                                color: Colors.black,
                              ),
                              title: Text(data["OrderName"]),
                              subtitle: Text(data["Note"]),
                              //      subtitle: Text(data["Note"]),
                              // ,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: GridView.count(
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: [
                              ...dataItemIds.map((e) {
                                return Card(

                                  elevation: 5,
                                  child: StreamBuilder(
                                    stream: itemCollection.snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return !snapshot.hasData
                                          ? Text("wait")
                                          : Container(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              ...snapshot.data!.docs.map((a) {
                                                return a.id == e
                                                    ? Column(
                                                  children: [
                                                    Text(
                                                        a["Quantity"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      a["title"].toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                )
                                                    : Container();
                                              })
                                            ],
                                          ));
                                    },
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(

                  child: Card(
                    color: Colors.black,
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("offers for this order ",
                      style: TextStyle(fontSize: 15 ,color: Colors.white),),
                    ),
                  ),
                ),
                
                SingleChildScrollView(
                  child: Container(
                   //color: Colors.red,
                    padding: EdgeInsets.all(20),
                    child: StreamBuilder(
                    stream: offerCollection.snapshots(),
                    builder: (context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                      return !snapshot.hasData
                          ? Center(child: CircularProgressIndicator())
                          : GridView.count(
                          crossAxisSpacing: 10,
                        crossAxisCount: 2,
                                      shrinkWrap: true,
                                      children: [
                                  ...snapshot.data!.docs.where((element) => element["orderId"]==orderid).map((e) {
                                    return  InkWell(
                                      onTap: () {
                                       showDialog(
                                           context: context,
                                           builder: (context)=> AlertDialog(
                                             title: Text("The Offer"),
                                             content: Container(

                                               child: Column(
                                               children: [
                                                 Text(e["offerTitle"],style:TextStyle(color: Colors.black54,fontSize: 18)),
                                                 Divider(height: 20,indent: 5,endIndent: 5,),
                                                 Text("The Available Quantity:",style: TextStyle(fontWeight: FontWeight.w800 ),),
                                                 Divider(indent: 60,endIndent: 60,),
                                                 SizedBox(height: 10,),
                                                 Text(e["avaiQuantity"],),

                                                 Divider(height: 20,indent: 5,endIndent: 5,),

                                                 Text("With Price:",style: TextStyle(fontWeight: FontWeight.w800 )),
                                                 Divider(indent: 60,endIndent: 60,),
                                                 Text(e["price"] + " \$"),
                                                 SizedBox(height: 10,),
                                               ],),
                                             ),


                                             actions: [
                                               OutlinedButton(
                                                 onPressed: ()=> Navigator.pop(context),
                                                 style: ButtonStyle(
                                                   shape: MaterialStateProperty.all(
                                                       RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(30.0),

                                                       )
                                                   ),
                                                   overlayColor: MaterialStateProperty.all<Color>(Colors.tealAccent)

                                                 ),
                                                 child: const Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 10),),
                                               ),
                                             OutlinedButton.icon(
                                               icon: Icon(FontAwesomeIcons.whatsapp),
                                             label: Text("Contact with me",style: TextStyle(color: Colors.black,fontSize: 10),),
                                             onPressed: (){
                                              // FlutterOpenWhatsapp.sendSingleMessage("+967717800036", "hhhh");
                                             },
                                             style: ButtonStyle(
                                               shape: MaterialStateProperty.all(
                                                   RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(30.0),

                                                   )
                                               ),
                                             ),
                                            // child: const Text("Contact with me",style: TextStyle(color: Colors.black),),
                                           )
                                             ],
                                           ),
                                       );

                                      },
                                      child: Card(
                                        color: Colors.teal,
                                          elevation: 15,
                                           child: Container(
                                             //color: Colors.red,
                                             padding: EdgeInsets.all(14),
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [


                                                 Text("I offer you :",style: TextStyle(color: Colors.white,fontSize: 10)),
                                                 const SizedBox(height: 8,),
                                                 Text(e["offerTitle"],style: TextStyle(color: Colors.black,fontSize: 7),
                                                   overflow: TextOverflow.ellipsis,
                                                   softWrap: true,
                                                   maxLines: 1,

                                                 ),
                                                 //const SizedBox(height: 10,),
                                                 Text("with this price:",style: TextStyle(color: Colors.white,fontSize: 10)),
                                                 const SizedBox(height: 8,),
                                                 Text(e["price"]),
                                                // Text(e["note"]),
                                                // Text(e["orderId"]),

                                               ],
                                             ),
                                           )),
                                    );

                                    }
                                ),]
                                    );



                          })


                  ),
                ),
              ],
            ),

          ),
        ),
      );
    } else
      return Container();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Single order"),
      ),
      body: Container(
        child:singleOrder(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed("/new_offer",arguments: {"orderId":orderid});
        },
        backgroundColor: Colors.black,
        child: Text("+"),),
    );
  }
  Future<String> downloadURLExample(String imagePath) async {

    var downloadURL = await FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();

    //print(downloadURL.toString());
    return downloadURL;
  }
}


/*StreamBuilder(
                   stream: offerCollection.snapshots(),
                   builder: (context,
                       AsyncSnapshot<QuerySnapshot> snapshot) {
                     return !snapshot.hasData
                         ? Text("wait")
                         :
                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          ...snapshot.data!.docs.map((a) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(
                                      a["note"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 15)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    a["price"].toString(),
                                    style: const TextStyle(
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            );
                          })
                        ],


                      );
                   }),*/



/*Container(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: StreamBuilder(
                stream: offerCollection.snapshots(),
                builder: (context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
                  return !snapshot.hasData
                      ? Text("wait")
                      : Column(
                                  children: [
                              ...snapshot.data!.docs.map((e) {
                                return e["orderId"] == orderid
                                    ? GridView.count(
                                  shrinkWrap: true,
                                      crossAxisCount: 2,
                                      children:[ Card(
                                      child: Column(
                                        children: [

                                          Text(e["offerTitle"]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(e["price"]),
                                          Text(e["note"]),
                                          Text(e["orderId"]),

                                        ],
                                      )),
                                    ]):Container();

                                }
                            ),]
                                );



                      })


              ),*/