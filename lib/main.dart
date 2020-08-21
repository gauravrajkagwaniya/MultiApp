import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.yellow,
        accentColor: Colors.grey,
        buttonColor: Colors.black,
      ),
//       routes: {
//         '/': (BuildContext context) => LogIn(),
//        '/homepage': (BuildContext context) => HomePage(user: widget.user,),
//
//       },
      home: LogIn(),
    );
  }
}
