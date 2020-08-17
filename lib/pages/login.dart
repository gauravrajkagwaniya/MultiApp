import 'package:flutter/material.dart';
import 'package:login_signup/pages/homepage.dart';
import 'regi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  final Map<String,dynamic> _formData ={
//    'email': null,
//    'password': null,
//  };
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/login.jpg'), fit: BoxFit.cover)
              //image
              ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text('login & sign up'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.white70),
                          //autovalidate: true,
                          validator: (String value) {
                            if (value.isEmpty ||
                                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                              return 'please enter email';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value,
//                          onSaved:(String value){_formData['email']= value;} ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white70),
                          obscureText: true,
                          // autovalidate: true,
                          validator: (String value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'password invalid';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value,
//                            onSaved:(String value){_formData['password']= value;},
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('Login'),
                        onPressed: _submitLogForm,
                      ),
                      OutlineButton(
                        textColor: Colors.white,
                        child: Text('Sign up'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Regi(),
                                  fullscreenDialog: true));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Future<void> _submitLogForm() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        final FirebaseUser user = result.user;
        //to go home

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
