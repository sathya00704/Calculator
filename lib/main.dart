import 'package:flutter/material.dart';
import 'package:calculator/home.dart';
import 'package:calculator/dark.dart';

void main() {
  runApp(MyApp());
}

/*
class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
*/

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      home: showSignIn ? Home(toggleView: toggleView) : DarkMode(toggleView: toggleView),
    );
    /*if(showSignIn){
      return Home(toggleView: toggleView);
    }
    else {
      return DarkMode(toggleView: toggleView);
    }*/
  }
}
