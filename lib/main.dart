import 'package:between/draftCode/insertButNew.dart';
import 'package:between/orders/fetchOrders.dart';
import 'package:between/orders/singleOrder.dart';
import 'package:get_storage/get_storage.dart';
import 'draftCode/InsertOrderold.dart';
import 'package:between/splash.dart';
import 'draftCode/sth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:between/first.dart';
import 'package:get/get.dart';

import 'offers/NewOffer.dart';
import 'orders/InsertItem.dart';
import 'orders/InsertOrder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

        getPages: [
          GetPage(name: "/home", page: () => HomePageWidget()),
          GetPage(name: "/insert_item", page: () => insertItem()),
          GetPage(name: "/insert_order", page:()=>  insertOrder()),
          GetPage(name: "/fetch_orders", page:()=>  fetchOrders()),
          GetPage(name: "/single_order", page:()=>  singleOrder()),
          GetPage(name: "/new_offer", page:()=>  newOffer())
        ],

    home: SplashScreen(),
    );
  }
}

