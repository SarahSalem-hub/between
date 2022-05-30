import 'package:flutter/material.dart';

class DynamicItem extends StatelessWidget {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerQuan = TextEditingController();
  TextEditingController controllerNote = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [

                        Container(
                          color: Colors.red,
                          child: Row(
                            children: [
                              itemCount(1),
                            ],
                          ),
                        ),

                        TextField(
                          controller: controllerTitle,
                          decoration:
                              const InputDecoration(hintText: 'Enter title '),
                        ),
                        TextField(
                          controller: controllerQuan,
                          decoration:
                              const InputDecoration(hintText: 'Enter Quantity '),
                        ),
                        TextField(
                          controller: controllerNote,
                          decoration:
                              const InputDecoration(hintText: 'Enter Note '),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class itemCount extends StatefulWidget {
  //const itemCount({Key? key}) : super(key: key);

  @override
  _itemCountState createState() => _itemCountState();
  var itemsCount = 3;
  itemCount(itemsCount){
    this.itemsCount++;
  }


}

class _itemCountState extends State<itemCount> {


  @override
  Widget build(BuildContext context) {
    var itemsCount = 3;

    return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("Item no. $itemsCount",style: TextStyle(),),

        ],

    );
  }
}

