import 'package:flutter/material.dart';



class InfoUser extends StatelessWidget {

  final String textt;
  final IconData icon;
  final VoidCallback onPressedd;

  InfoUser({required this.textt,
    required this.icon,
    required this.onPressedd

  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedd,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: ListTile(
          leading: Icon(icon,color: Colors.teal,

          ),
          title: Text(
            textt,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 15,

            ),
          ),
        ),
      ),
    ) ;
  }
}