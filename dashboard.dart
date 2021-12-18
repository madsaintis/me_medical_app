// ignore_for_file: prefer_const_constructors



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/edit_profile.dart';
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
          title: Text('Welcome,User',style: TextStyle(color: Colors.white),),
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
              color: Colors.white,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              },
            ),
          ],
        ),
        body: Center(
            child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            //has a problem to read a data from database and draw the diagram.
            GestureDetector(
              onTap:(){},
              child:Image.asset(
                'assets/images/income.png',
                fit:BoxFit.cover,
                width:200,
                height:200,
              )
            ),
            SizedBox(
              height:20,
            ),

            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Patient Check Up',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
              ),
              //later implement the jump page function
              onPressed: () {},
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
              onPressed: () {},
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
              onPressed: () {},
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        )));
  }
}