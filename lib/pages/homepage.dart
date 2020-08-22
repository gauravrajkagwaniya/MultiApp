import 'package:flutter/material.dart';
import 'package:login_signup/main.dart';
import 'package:login_signup/pages/login.dart';
import 'package:login_signup/pages/ollo_cabs.dart';
import 'weekly.dart';
import 'calender.dart';
import 'my_order.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
  final FirebaseUser user;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Date'),
        centerTitle: true,

      ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text('Gaurav raj'),
              accountEmail: new Text('${widget.user.email}'),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text("G"),
              ),
            ),
            ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(user: widget.user)));
              },
            ),
            new Divider(),
            ListTile(
              title: new Text("week calender"),
              trailing: new Icon(Icons.calendar_today),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeekCal()));
              },
            ),
            new Divider(),
            ListTile(
              title: new Text("My Orders"),
              trailing: new Icon(Icons.card_travel),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrder()));
              },
            ),
            new Divider(),
            ListTile(
              title: new Text("Ollo Cabs"),
              trailing: new Icon(Icons.local_taxi),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OlloCabs()));
              },
            ),
            new Divider(),
            ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.directions_walk),
              onTap: _logOut,
            ),
            new Divider(),
          ],
        ),
      ),
      body: Calender(),
    );
  }

  Future<LogIn> _logOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=> LogIn()),(Route<dynamic> route)=>false);
  }
}
