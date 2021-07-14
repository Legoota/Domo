import 'package:flutter/material.dart';
import 'dart:math' show Random;

class Choix extends StatefulWidget {
  _ChoixState createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {

  List<String> mealList = ['Ungut', 'Burger King', 'UFA Burger', 'Malker', 'Pain du Grand Père']; // TODO: Add firestore database link
  String _currentChoice ="";

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  void mealChoice() {
    final _randomChoice = new Random();
    setState(() {
      _currentChoice = mealList[_randomChoice.nextInt(mealList.length)];
    });
  }

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
          SizedBox(height: 100),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '$_currentChoice',
              style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(.7, 1.8),
                    blurRadius: 3.0,
                    color: Color.fromARGB(225, 0, 0, 0),
                  )
                ],
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                foreground: Paint()..shader = linearGradient),
                textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 100),
                child : ElevatedButton.icon(
                  label: Text('Miam'),
                  icon: Icon(Icons.local_pizza_outlined),
                  onPressed: () {
                    mealChoice();
                  },
                )
              )
            )
          )
        ],
      )
    );
  }
}