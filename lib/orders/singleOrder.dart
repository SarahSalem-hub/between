import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class singleOrder extends StatefulWidget {
  const singleOrder({Key? key}) : super(key: key);

  @override
  _singleOrderState createState() => _singleOrderState();
}

class _singleOrderState extends State<singleOrder> {
  final orderid = Get.arguments["oId"];
  CollectionReference orderCollection = FirebaseFirestore.instance
      .collection("order")
      .doc("ordersGroup")
      .collection("SingleOrder");

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
          Get.toNamed("/new_offer");
        },
        backgroundColor: Colors.black,
        child: Text("+"),),
    );
  }
}

Widget detailedOrdered(
    String id, String dataId, QueryDocumentSnapshot<Object?> data) {
  DateTime dt = (data["Date"] as Timestamp).toDate();
  var dataItemIds = data["ItemIds"].toList();
  CollectionReference itemCollection = FirebaseFirestore.instance
      .collection("items")
      .doc("itemsGroup")
      .collection("Singleitems");

  if (id == dataId) {
    return Flexible(
      child: SingleChildScrollView(
        child: Card(
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
            )),
      ),
    );
  } else
    return Container();
}
