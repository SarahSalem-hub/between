


import 'package:cloud_firestore/cloud_firestore.dart';

class DbOrder {

  CollectionReference dbCollection =
  FirebaseFirestore.instance.collection("order");

  String addOrder (String location ,String note ,DateTime date , List itemsIDS){
    var order;
    try{
      order =
      {
        'Location':location,
        'Note':note ,
        'Date':date,
        'ItemIds':itemsIDS
      };
      dbCollection
          .doc("ordersGroup")
          .collection("SingleOrder").add(order);

    }
    catch(e){
      print("order error "+e.toString());
    }
      return "fhd";
  }

}