import 'package:domo/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' show Random;
import 'restaurant.dart';

class Choix extends StatefulWidget {
  _ChoixState createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {

  String _currentChoice ="";
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('restaurants');

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  Future<void> mealChoice() async {
    List<Restaurant> availableChoices = await getAllRestaurants();
    final _randomChoice = new Random();
    setState(() {
      _currentChoice = availableChoices[_randomChoice.nextInt(availableChoices.length)].nom!;
    });
  }

  Future<List<Restaurant>> getAllRestaurants() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    List<Restaurant> allRestaurants = [];

    // Get data from docs and convert them to List<Restaurant>
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    allData.forEach((element) {
      Map<String, dynamic> resto = element as Map<String, dynamic>;
      allRestaurants.add(Restaurant.fromJson(resto));
    });

    return allRestaurants;
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