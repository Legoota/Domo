import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math' show Random;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Domo());
}

class Domo extends StatelessWidget {

  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domo',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print("Erreur ! ${snapshot.error.toString()}");
            return Text("Une erreur est survenue !");
          } else if (snapshot.hasData) {
            return HomePage(title: 'Dimitri, on mange où ?');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        })
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<HomePage> {

  List<String> mealList = ['Ungut', 'Burger King', 'UFA Burger', 'Malker', 'Pain du Grand Père'];
  String _currentChoice ="";

  void mealChoice() {
    final _randomChoice = new Random();
    setState(() {
      _currentChoice = mealList[_randomChoice.nextInt(mealList.length)];
    });
  }

  Widget choix = Container(
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
        Text("Choix restaurant ici"),
        ElevatedButton.icon(
          label: Text('Miam'),
          icon: Icon(Icons.local_pizza_outlined),
          onPressed: () {
            print("new choice");
          },
        )
      ],
    )
  );

  Widget ajout = Container(
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

  Widget modification = Container(
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.local_pizza)),
              Tab(icon: Icon(Icons.library_add)),
              Tab(icon: Icon(Icons.mode_edit)),
            ],
          ),
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: [
            choix,
            ajout,
            modification,
          ],
        ),
      ),
    );
  }
}