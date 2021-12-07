// ignore_for_file: prefer_const_constructors

import 'package:me_medical_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/add_item.dart';
import 'package:me_medical_app/dashboard.dart';

// ignore: use_key_in_widget_constructors
class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  //final AuthService _auth = AuthService();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('items')
      .where('User ID', isEqualTo: AuthService().getCurrentUID())
      .snapshots();
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Medical Inventory"),
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
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (!snapshot.hasData) {
              return Text("No item added in the inventory yet.",
                  textAlign: TextAlign.center);
            } else {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['Item Name']),
                    subtitle: Text(data['In Stock']),
                  );
                }).toList(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            elevation: 0.0,
            label: Text('Add Item'),
            icon: Icon(Icons.add),
            backgroundColor: Color(0xFFE57373),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddItemPage()));
            }));
  }
}
