import 'package:between/Home/notifiction.dart';
import 'package:between/Home/page1.dart';
import 'package:between/Home/page3.dart';
import 'package:between/Home/page4.dart';
import 'package:between/orders/fetchOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Home/notifiction.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Between ',

      theme: ThemeData(

        primaryColor: Colors.black,
      ),


      home:mainScreen(),

    );
  }
}
class mainScreen extends StatefulWidget {

  @override
  State<mainScreen> createState() => _mainScreenState();
}



//مضمون  كلاس _HomePageState يتضمن فيه ايقونه البحث التي قمنا بااستدعاء الدالة المخصصة لها وايضا يتضمن ايقونة الاشعارات وصفحتها وايضا يحتوي على عناصر ال App Bar كما يتضمن شريط التنقل لايقونة للمحادثات والاعدادات والمفضلة والصفحة الرئسيسية التي بااسفل الصفحة
class _mainScreenState extends State<mainScreen> with SingleTickerProviderStateMixin{


  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController=TabController(length: 3, vsync: this);
  }
  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  var uidDrawer =  Get.arguments["userId"];
  var uEmailDrawer =  Get.arguments["userEmail"];


  @override
  Widget build(BuildContext context) {
   // CollectionReference userProfile = FirebaseFirestore.instance.collection("Users");
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(title),
      //   centerTitle: true,
      //   actions: <Widget>[
      //
      //     IconButton(icon: Icon(Icons.search), onPressed:null,),
      //
      //   ],
      //
      //   elevation: 0.0,
      // ),
      // drawer:Drawer(
      //
      //   child: ListView(
      //     children: [
      //
      //       StreamBuilder(
      //         stream: userProfile.snapshots(),
      //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //           return !snapshot.hasData
      //               ? Text("loading ..")
      //               : Column(
      //             children: [
      //           ...snapshot.data!.docs.where((element) => element["Uid"]== uidDrawer ).map((e)
      //             {
      //               return UserAccountsDrawerHeader(
      //                 decoration: BoxDecoration(
      //                   color: Colors.black54,
      //                 ),
      //               currentAccountPicture: FutureBuilder(
      //                 future: downloadURLExample(e["ProfilePath"]),
      //                 builder: (context,snapshot){
      //                   return snapshot.hasData
      //                       ? CircleAvatar(
      //
      //                     backgroundColor: Colors.white,
      //                     backgroundImage: NetworkImage(snapshot.data.toString()),)
      //                       : CircleAvatar(backgroundColor: Colors.grey);
      //                 },
      //               ),
      //             accountName:Text(e["UserName"]) ,accountEmail: Text(uEmailDrawer),
      //             );
      //             }
      //           )],
      //           );
      //
      //           }),
      //
      //
      //       ListTile(
      //         leading: Icon(Icons.info),
      //         title: Text("About us"),
      //
      //       ),
      //
      //       ListTile(
      //         leading: Icon(Icons.help),
      //         title: Text("Help"),
      //
      //       ),
      //     ],
      //   ),
      // ),

      body:

      Center(
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children:<Widget> [
            Page1(),
            fetchOrders(),
            Page4(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.white,
          indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 0.0),
          ),
          labelColor: Colors.pinkAccent,
          labelStyle: TextStyle(fontSize: 14.0),
          tabs:<Widget> [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),


            Tab(
              icon: Icon(Icons.chat),
              text: "Orders",
            ),
            Tab(
              icon: Icon(Icons.supervised_user_circle_outlined),
              text: "Account",
            ),

          ],
        ),
      ),

    );
  }


}



//   هذه الدالة الخاصة بالبحث بحيث قمت باانشاء عدة عناصر للبحث ومن ثم قمت بااستدعاءها في دالة _HomePageState في ابقونة البحث
class DataSearch extends SearchDelegate<String>{

  final categories=[
    "Pharmacy",
    "Beauty",
    "Medical",
    "Furniture",
    "School",
    "Builiding",
    "Food"
  ];
  final RecentsCategories =[
    "Medical",
    "Furniture",
    "School",
    "Builiding"
  ];




  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(icon: Icon(Icons.clear),onPressed:(){
        query="";
      } ,)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon:AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress:transitionAnimation,
        ) ,
        onPressed: (){
          close(context, "null");
        });

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    // throw UnimplementedError();
    final suggetionsList = FirebaseFirestore.instance
        .collection("order")
        .doc("ordersGroup")
        .collection("SingleOrder")
        .where("OrderName",isGreaterThanOrEqualTo:"foodstuffs" ).snapshots();
    return ListView.builder(itemBuilder: (context, index) => ListTile(

      leading: Icon(Icons.location_city),
      title: Text(suggetionsList.forEach((e) {e.toString();}).toString())
    ),
    // itemCount: suggetionsList,
    );


  }
}

