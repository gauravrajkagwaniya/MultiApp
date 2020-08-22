import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Regi extends StatefulWidget {
  @override
  _RegiState createState() => _RegiState();
}

class _RegiState extends State<Regi> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
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
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text('Create an account', style: TextStyle( fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent,
                            shadows:[Shadow(color: Colors.brown,blurRadius: 2.0,offset: Offset(4,1))
                            ]



                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.white70),
                          // autovalidate: true,
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
                        child: Text('Sign up'),
                        onPressed: _submitRegiForm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Future<void> _submitRegiForm() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        final FirebaseUser user = result.user;
        //to go home

        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
