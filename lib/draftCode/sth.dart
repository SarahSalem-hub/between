import 'dart:convert';
import 'dart:math';

import 'package:between/orders/orderConnection/db_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

class insert extends StatefulWidget {
  const insert({Key? key}) : super(key: key);

  @override
  _insertState createState() => _insertState();
}

class _insertState extends State<insert> {
  TextEditingController OrderName = TextEditingController();
  TextEditingController OrderDes = TextEditingController();
  TextEditingController OrderEndDate = TextEditingController();

  CollectionReference dbCollection =
  FirebaseFirestore.instance.collection("orders");
  late int _count;
  late String _result;
  late List<Map<String, dynamic>> _values;
  late List<Map<String, dynamic>> _item;
  late Map <String, dynamic> item;
  int index=0;
  int foundkey = -1;


  @override
  void initState() {
    super.initState();
    _count = 0;
    _result = ' ';
    _values= [];
    _item = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    _count++;
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: <Widget>[


            Container(
              padding: EdgeInsets.all(5),
              color: Colors.red,
              child: RoundedButton(
                onPressed: () async {
                  setState(() {
                    _count++;
                  });
                  Fluttertoast.showToast(msg: _count.toString());
                },
                title: "+ ",
              ),
            ),
            Flexible(
              flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  //color: Colors.blue,
                  child:
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _count,
                          itemBuilder: (context,index)
                          {
                            return _row(index);
                          }
                      )


                )
            ),
            SizedBox(height: 20,),
            Text(_result),
          ],
        )

    );
  }

  _row(int key) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red)
      ),

      child: Row(
        children: [
          Text("ID:$key"),
          SizedBox(width: 30.0,),
          Expanded(child: TextFormField(
      textInputAction: TextInputAction.go,
            onChanged: (val){
              _onUpdate(key,val);
            },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Order Description")
          ),
          ),
          Expanded(child: TextFormField(
              textInputAction: TextInputAction.go,
              onChanged: (val){
                _onUpdate(key,val);
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Order Description")
          ),
          ),
          
          
        ],
      ),
    );
  }
    _onUpdate(int key , String val){

      for(var v in _values )
      {
        if(v.containsKey('id')){
          if(v['id'] == key)
          {
            foundkey = key;


            break;
          }
        }

      }
      if (-1 != foundkey)
      {
        _values.removeWhere((v) { return v['id'] == foundkey;});

      }

    for(var i in _item )
    {
        if(i.containsKey('id')){
          if(i['id'] == index)
            {
              _item.add(item);
              index++;
              i['id']=index;
              break;
            }
          }
    }
    if (-1 != index)
      {
        _item.removeWhere((i) { return i['id'] == index;});
        print ("here3: $index" );
      }



      item = {"id": index ,"item":val};
    //print ("here4: $index" );

    Map<String, dynamic> json = {
        "id":key ,
        "value": item
    };

    _values.add(json);

      //index++;
    setState(() {
      //_result= _pretty(_values);

    });
    print(_pretty(_values));
    }

      _pretty(jsonObject){
        var encoder= JsonEncoder.withIndent("    ");
     return encoder.convert(jsonObject);


    }

}