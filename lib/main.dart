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
  Widget choix = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Text("Choix restaurant"),
  );

  Widget ajout = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Text("Page ajout restaurant"),
  );

  Widget modification = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Text("Page modification restaurant"),
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


/*
class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("domo");
    _testRef.set("Testing a random number: ${Random().nextInt(100)}");
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}*/