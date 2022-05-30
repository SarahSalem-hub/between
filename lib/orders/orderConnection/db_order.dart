


import 'package:cloud_firestore/cloud_firestore.dart';

class DbOrder {

  CollectionReference dbCollection =
  FirebaseFirestore.instance.collection("order");

  String addOrder (String uid,String orderName,String location ,String note ,DateTime date , List itemsIDS){
    var order;
    try{
      order =
      {
        'OrderName':orderName,
        'Location':location,
        'Note':note ,
        'Date':date,
        'ItemIds':itemsIDS,
        'uid':uid,
        'NowDate':DateTime.now()
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