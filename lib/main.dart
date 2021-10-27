import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class User {
  String? name = "";
  String? email = "";
  String? phone = "";
  String? address = "";

  User(this.name,this.email,this.phone,this.address);

  User.fromJson(Map<dynamic, dynamic> json)
      :
        name = json['name'] as String,
        email = json['email'] as String,
        phone = json['phone'] as String,
        address = json['address'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name.toString(),
    'email': email.toString(),
    'phone': phone.toString(),
    'address': address.toString(),
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DatabaseReference  userRef = FirebaseDatabase.instance.reference().child("users");


  void _register() {
    // Map<String, String> map = HashMap<String, String>();
    //
    // map["name"] = "Sonu Kumar";
    // map["email"] = "skbhati199@gmail.com";
    // map["phone"] = "+9810659036";
    // map["address"] = "Devi Mandir";


    User user = User("Sonu Kumar Bhati", "skbhati199@gmail.com", "+91-9810659035", "Devi Mandir Khatirwara");

    userRef.push()
        .set(user);

    userRef.child("-Mn0xRzkI8NzLGyjBBc2").update(user).then((snapshot) {

    })
    .catchError((error) => {
      debugPrint(error)


    });


  }

  @override
  Widget build(BuildContext context) {

    String email = "skbhati199@gmail.com";

    userRef.child("-Mn0rLa7YofbSq2XaWSn").once().then((snapshot) {
      print(snapshot);
      // result

      final json = snapshot.value as Map<dynamic, dynamic>;

     User user =  User.fromJson(json);

      print("Name ${user.name}");
      print("email ${user.email}");
      print("phone ${user.phone}");
      print("address ${user.address}");

    }
    ).catchError((error) => {
      debugPrint(error)
    });




    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Register',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _register,
        tooltip: 'Register',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
