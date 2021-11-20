import 'package:flutter/material.dart';
import 'package:me_medical_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Sign in to Brew Crew'),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.app_registration),
                label: Text("Register"))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Please fill username field";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Please fill password field";
                      }
                      return null;
                    },
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  ElevatedButton(
                      child: Text('Sign In',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.logIn(email, password);
                          if (result == null) {
                            setState(() => error = 'Wrong credentials');
                          }
                          print(email);
                          print(password);
                        }
                      }),
                  SizedBox(height: 20.0),
                  Text(error, style: TextStyle(color: Colors.red))
                ]))));
  }
}
