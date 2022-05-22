

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class newOffer extends StatefulWidget {
  const newOffer({Key? key}) : super(key: key);

  @override
  _newOfferState createState() => _newOfferState();
}

class _newOfferState extends State<newOffer> {

  Widget orderForm = Card(

    //color: Colors.yellow,
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          //key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                //controller: orderName,
                decoration:  InputDecoration(
                  hintText: 'I offer you ..',
                  icon: FaIcon(FontAwesomeIcons.pen,color: Colors.black,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black,),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                ),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the offer title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),

              TextFormField(
                //controller: location,
                decoration:  InputDecoration(
                  hintText: 'The available quantity..',
                  icon: FaIcon(FontAwesomeIcons.boxes,color: Colors.black,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black,),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                ),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity you have ';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                //controller: location,
                decoration:  InputDecoration(
                  hintText: 'With this price..',
                  icon: FaIcon(FontAwesomeIcons.moneyBillWave,color: Colors.black,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black,),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                ),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price you\'re offering.. ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
               // controller: note,
                decoration:  InputDecoration(
                  hintText: 'Enter Note',
                  icon: FaIcon(FontAwesomeIcons.stickyNote,color: Colors.black,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.black,),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),),
                ),
              ),

              SizedBox(height: 20,),
              Container(
                  color: Colors.red,
                  width: 400,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {}
                    ,
                    child: Text("Offer"),
                    textColor: Colors.white,
                    color: Colors.black,
                  )

              ),

            ],
          ),
        ),
      ));



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("New Offer "),
      ),
        body:SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  orderForm,
                ],
              ),
            ),
          ),
        )

    );
  }
}
