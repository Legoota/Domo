import 'package:domo/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ajout extends StatefulWidget {
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController villeController = TextEditingController();

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('restaurants');

    void addRestaurant(Restaurant r) {
      _collectionRef
          .add({
            "Nom": r.nom,
            "Type": r.type,
            "Ville": r.ville
          })
          .then((value) => snackBarTrigger("${r.nom} a été ajouté !"))
          .catchError((error) => snackBarTrigger("Erreur de l'ajout de ${r.nom}: $error"));
    }

    void snackBarTrigger(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
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
             child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nomController,
                  decoration: const InputDecoration(
                    hintText: 'Nom du restaurant',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatoire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: typeController,
                  decoration: const InputDecoration(
                    hintText: 'Type',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatoire';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: villeController,
                  decoration: const InputDecoration(
                    hintText: 'Ville',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatoire';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton.icon(
                      label: Text('Ajouter'),
                      icon: Icon(Icons.library_add_outlined),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ajout du nouveau restaurant...')),
                          );
                          Restaurant r = new Restaurant(nomController.text, typeController.text, villeController.text);
                          addRestaurant(r);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
          )
        ],
      )
    );
  }
}