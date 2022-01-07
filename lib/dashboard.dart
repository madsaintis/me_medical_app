// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/edit_profile.dart';
import 'package:me_medical_app/inventory.dart';
import 'package:me_medical_app/patient_checkup.dart';
import 'package:me_medical_app/patient_list.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/wrapper.dart';

// ignore: use_key_in_widget_constructors
class Dashboard extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          centerTitle: true,
          title: Text('Dashboard'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Wrapper()),
                        (route) => false));
              },
            ),
          ],
        ),
        body: Center(
            child: ListView(
          padding: EdgeInsets.all(50.0),
          children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Patient Check Up',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
              ),
              //later implement the jump page function
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientCheckUp()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton.icon(
              icon: Icon(Icons.list_alt),
              label: Text('Patient Information',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
              ),
              //later implement the jump page function
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientListPage()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton.icon(
              icon: Icon(Icons.medication),
              label: Text('Medical Inventory',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
              ),
              //later implement the jump page function
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InventoryPage()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        )));
  }
}
