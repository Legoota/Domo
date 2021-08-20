import 'package:flutter/material.dart';

class Ajout extends StatefulWidget {
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Ajoutez un restaurant ici !"),
          ElevatedButton.icon(
            label: Text('Ajouter'),
            icon: Icon(Icons.library_add_outlined),
            onPressed: () {
              print("add");
            },
          )
        ],
      )
    );
  }
}