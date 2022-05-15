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

  Future addItem (String location,String note ,DateTime date) async {
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
         dbCollection
              .doc("itemsGroup")
              .collection("Singleitems").add(item)
              .then((e)  {
            itemIds.add(e.id);
            print("sgsg");


          });



          //print(await itemIds.toString());
         // return Order();
        //});



        ////inside then
        // print(e.id.toString());
        // itemIds.add(e.id);
        // print("length here inside");
        // print (itemIds.length);
        // print (itemIds.toString());
        //
        // box.write("id", itemIds);
        //////



      });

    // return itemIds;
       Future.delayed(Duration(seconds: 5), ()  {


         DbOrder().addOrder(location, note, date, itemIds);
         print("kkkkkk");
         // return itemIds;

         print(itemIds);

       });
    }

    catch (e){
      print("here "+e.toString());


    }
  }

  Future<List> Order ()async{

    //box.erase();
    //addItem();
    // print ("data");
    // print (list);
    //  print ("box");
    //  print(box.read("id"));
    print ("item length in order:");
    print (itemIds.length);
    //
     print ("item IDS in order:");
     print (itemIds);
    return itemIds;
  }

}

