import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/edit_profile.dart';
import 'package:me_medical_app/services/auth.dart';

class Dashboard extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Dashboard'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              child: Text("Profile Page"))),
    );
  }
}
