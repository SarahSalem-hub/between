import 'dart:core';
import 'dart:core';

import 'package:between/orders/orderConnection/db_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';


class DbItem {
  List k=[];
  List itemIds = [];
  var returnedIDS;
  var list = Get.arguments[0] as List;
  final box = GetStorage();

  var docRef;

  CollectionReference dbCollection =
   FirebaseFirestore.instance.collection("items") ;


  Future addItem (String uid,String orderName ,String location,String note ,DateTime date) async {
    var item;
    int count =0;

    //box.erase();
     try{
       print("liiiiiist");
       //list.asMap();
      list.forEach((element)   async {

        //k = element.values.last.toList;
        print(element);
        item =
            {
              'id':element["id"],
              'title':element["item"][0],
              'Quantity':element["item"][1],
              // 'Location':location,
              // 'Note':note ,
              // 'Date':date
            };

       // Future.delayed(Duration(seconds: -2), () async {await
        await dbCollection
              .doc("itemsGroup")
              .collection("Singleitems").add(item)
              .then((e)  {
            itemIds.add(e.id);
            print("sgsg");


          });



      });

    // return itemIds;
      await Future.delayed(Duration(seconds: 5), ()  {


         DbOrder().addOrder(uid,orderName,location, note, date, itemIds);
         print("kkkkkk");
         // return itemIds;

         print(itemIds);

       });
    }

    catch (e){
      print("here "+e.toString());


    }
    return "yes";
  }

  Future<List> Order ()async{

    print ("item length in order:");
    print (itemIds.length);
    //
     print ("item IDS in order:");
     print (itemIds);
    return itemIds;
  }

}

