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
