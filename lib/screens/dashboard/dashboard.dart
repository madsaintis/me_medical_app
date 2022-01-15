// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/profile_pages/view_profile.dart';
import 'package:me_medical_app/screens/inventory/inventory.dart';
import 'package:me_medical_app/screens/checkup_pages/patient_checkup.dart';
import 'package:me_medical_app/screens/patients_info/patient_list.dart';
import 'package:me_medical_app/services/wrapper.dart';

// ignore: use_key_in_widget_constructors
class Dashboard extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => ViewProfilePage()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Wrapper();
                        },
                      ),
                      (_) => false,
                    ));
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
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientListPage()));
              }, // Handle your callback
              child: Ink(
                height: 100,
                width: 100,
                color: Colors.blue,
                child: TextButton.icon(
                  icon: Icon(Icons.list_alt),
                  label: Text('Patient Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      )),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                  ),
                  //later implement the jump page function
                  onPressed: () {},
                ),
              ),
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
