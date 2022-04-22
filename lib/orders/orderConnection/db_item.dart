import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';


class DbItem{
  List k=[];
  List itemIds = [];
  var returnedIDS;
  var list = Get.arguments;
  final box = GetStorage();

  var docRef;

  CollectionReference dbCollection =
   FirebaseFirestore.instance.collection("order");



  // Future<Object> addorder ({String? orderName , String? Des ,String? EndDate , String? DocID})async{
  //
  //       try{
  //         final item =
  //             {
  //               'OrderName': orderName,
  //               'Notes': Des
  //             };
  //         final order =
  //         {
  //           'EndDate':EndDate,
  //           'itemID' :DocID,
  //           'items':
  //                 [
  //                     {'OrderName': orderName, 'Notes': Des}
  //                 ]
  //
  //         };
  //
  //        // dbCollection.doc("items").collection().add(order);
  //         //dbCollection.doc("item").set(order);
  //
  //           return Fluttertoast.showToast(msg: "Order Added");
  //       }
  //
  //       catch (e){
  //         print(e.toString());
  //         return e.toString();
  //
  //       }
  // }

  // Future<Object> item ({String? orderName , String? Des ,String? EndDate }) async
  // {
  //       return "";
  //
  // }

  // Future addOrder (Map map )async{
  //
  //   try{
  //
  //     map.forEach((key, value) {
  //       print ("key "+key.toString() );
  //       print ("value "+value.toString() );
  //       final item =
  //       {
  //         'number': key,
  //         'Notes': value
  //       };
  //       dbCollection.doc("items").collection("sth").add(item);
  //       print("did it ");
  //     });
  //
  //     return Fluttertoast.showToast(msg: "Order Added");
  //     return " f";
  //   }
  //
  //   catch (e){
  //     print("here "+e.toString());
  //     return e.toString();
  //
  //   }
  // }

  void addItem ( ){
    var item;
    // print ("box before");
    // print (box1.read("id"));
    //
    // box1.erase();
    //
    // print ("box after");
    // print (box1.read("id"));
    try{
      // print("list");
      // print (List);
      list.forEach((element)   async {
        k = element.values.last.toList();

        item =
            {
              'id':element.values.first,
              'title':k[0],
              'Quantity':k[1]
            };
        Future<String>.delayed(Duration(seconds: 3), () async {
          await dbCollection
              .doc("itemsGroup")
              .collection("items").add(item)
              .then((e) async {
            print(e.id.toString());
            itemIds.add(e.id);
            print("length");
            print (itemIds.length);

            box.write("id", itemIds);

            Order();

          });
          return "heeeeeeeeeerrreee";
        });




      });


    }

    catch (e){
      print("here "+e.toString());


    }
  }

  Future Order ()async{

    //box.erase();
    //addItem();
    // print ("data");
    // print (list);
     print ("box");
     print(box.read("id"));
    print ("item length in order:");
    print (itemIds.length);
    //
     print ("item IDS in order:");
     print (itemIds);
    return itemIds;
  }

}

