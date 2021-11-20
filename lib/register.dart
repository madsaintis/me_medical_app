import 'package:flutter/material.dart';
import 'package:me_medical_app/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  //text field state
  String name = '';
  String phone = '';
  String email = '';
  String password = '';
  String confirmpassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registration Page"),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: 30.0, right: 20.0, top: 20.0, bottom: 20.0),
          child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Name field can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Full Name ",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[200]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Phone number field can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => phone = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[200]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator: (String? val) {
                    if (val != null && val.isEmpty) {
                      return "Email field can't be empty";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[200]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (String? val) {
                    if (val != null && val.length < 6) {
                      return "Enter password with more than 6 characters";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[200]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) => (val == password) == false
                      ? "Enter the same password"
                      : null,
                  onChanged: (val) {
                    setState(() => confirmpassword = val);
                  },
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[200]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Center(
                    child: ElevatedButton(
                        child: Text("Register"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.register(
                                name, phone, email, password);
                            if (result == null) {
                              setState(
                                  () => error = 'Please supply a valid email');
                            }
                          }
                        },
                        style:
                            ElevatedButton.styleFrom(primary: Colors.amber))),
              ])),
        ));
  }
}
