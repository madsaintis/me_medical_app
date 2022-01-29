// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/dashboard/dashboard.dart';
import 'package:me_medical_app/screens/profile_pages/edit_profile.dart';
import 'package:me_medical_app/services/auth.dart';

// ignore: use_key_in_widget_constructors
class ViewProfilePage extends StatefulWidget {
  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String location = '';
  String password = '';
  String newpassword = '';
  String confirmnewpassword = '';
  String error = '';
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('User ID', isEqualTo: AuthService().getCurrentUID())
      .snapshots();
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Profile"),
        backgroundColor: Colors.teal,
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                name = data['Name'];
                email = data['Email'];
                phone = data['Phone'];
                location = data['Clinic Location'];

                return Form(
                    key: _formKey,
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            initialValue: data['Name'],
                            onChanged: (val) => name = val,
                            validator: (String? val) {
                              if (val != null && val.isEmpty) {
                                return "Name field can't be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Full Name ",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                return "Name field can't be empty";
                              }
                              return null;
                            },
                            onChanged: (val) => email = val,
                            initialValue: data['Email'],
                            decoration: InputDecoration(
                                labelText: "Email",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                          Row(
                            children: [
                              Text(
                                "Phone Number",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(data['Phone']),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            onChanged: (val) => location = val,
                            initialValue: data['Clinic Location'],
                            decoration: InputDecoration(
                                labelText: "Clinic Location",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                        ])));
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
/*
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Personal Information"),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(
                left: 30.0, right: 20.0, top: 20.0, bottom: 20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Name field can't be empty";
                      }
                      return null;
                    },
                    //initialValue: "Name",
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
                        return "Name field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    //initialValue: "user@yahoo.com",
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
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Name field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => phone = val);
                    },
                    //initialValue: "012-34567890",
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
                        return "Name field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => location = val);
                    },
                    //initialValue: "Jalan Resak",
                    decoration: InputDecoration(
                        labelText: "Clinic Location",
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
                  Center(
                      child: ElevatedButton(
                          child: Text("Change Information"),
                          onPressed: () async {
                            /*if (_formKey.currentState!.validate()) {
                              print(name);
                              setState(() => error = 'Changed successfully');
                              dynamic result = await _auth.editProfile(
                                  name, phone, email, location);

                              if (result == null) {
                                setState(() => error = 'Invalid inputs');
                              }
                            }*/
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber))),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Edit Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    validator: (String? val) {
                      if (val != null && val.length < 6) {
                        return "Enter password with more than 6 characters";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "New Password",
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
                    height: 10.0,
                  ),
                  TextFormField(
                    validator: (val) => (val == password) == false
                        ? "Enter the same password"
                        : null,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Confirm New Password",
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
                    height: 10.0,
                  ),
                  TextFormField(
                      validator: (String? val) {
                        if (val != null && val.length < 6) {
                          return "Enter password with more than 6 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Current Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[200]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ))),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: ElevatedButton(
                          child: Text("Change Password"),
                          onPressed: () {},
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green)))
                ]))));
  }
  */

/*
  _fetch() async {
    final _userFirebase = await FirebaseAuth.instance.currentUser;
    if (_userFirebase != null)
      await FirebaseFirestore.instance.doc(_userFirebase.uid).get().then((ds) {
        name = ds.data()?['Name'];
        email = ds.data()?['Email'];
        phone = ds.data()?['Phone'];
        location = ds.data()?['Location'];
        print(name);
      }).catchError((e) {
        print(e);
      });
  }
}
*/
