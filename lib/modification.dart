import 'package:flutter/material.dart';

class Modification extends StatefulWidget {
  _ModificationState createState() => _ModificationState();
}

class _ModificationState extends State<Modification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Modification restaurant ici !"),
          ElevatedButton.icon(
            label: Text('Modifier'),
            icon: Icon(Icons.mode_edit_outline_outlined),
            onPressed: () {
              print("edit");
            },
          )
        ],
      )
    );
  }
}