

import 'package:cloud_firestore/cloud_firestore.dart';

class db_offer {

  CollectionReference offerColl = FirebaseFirestore.instance.collection("offers");

  var offer ;
  void addOffer(String offerTitle , String availableQuantity,
      String price, String note , String singleOrderId ){

    try {

      offer ={
        "offerTitle":offerTitle,
        "avaiQuantity":availableQuantity,
        "price":price,
        "note":note,
        "orderId":singleOrderId
      };

      offerColl.add(offer);

    }
    catch (e) {
      print("here " + e.toString());
    }


  }

}