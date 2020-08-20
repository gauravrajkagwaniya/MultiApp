import 'package:flutter/material.dart';
import 'package:login_signup/pages/homepage.dart';
import 'regi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text('Multi App'),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login.jpg'), fit: BoxFit.cover,)
              //image
              ),
          padding: EdgeInsets.all(10.0),

            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 200,),

                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text('login & sign up', style: TextStyle( fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          shadows:[Shadow(color: Colors.brown,blurRadius: 2.0,offset: Offset(4,1))
                          ]



                        ),),
                      ),
                      SizedBox(height: 10,),
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
                      Column(
                        children: [
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
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Column( children: [
                             RaisedButton(
                              textColor: Colors.white,
                              child: Text('Login'),
                              onPressed: _submitLogForm,

                            ),
                          ],

                          ),

                          Column( children: [

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
                            ),

                          ],

                          ),
                            SizedBox(height: 200,),


                        ],

                        ),

                      ),

                    ],
                  ),
                ),
              ),

            ),
      ),
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
