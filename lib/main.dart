import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'choix.dart';

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
      debugShowCheckedModeBanner: false,
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

  final String title;

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<HomePage> {

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
            Choix(),
            ajout,
            modification,
          ],
        ),
      ),
    );
  }
}