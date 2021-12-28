import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/dashboard.dart';
import 'package:me_medical_app/inventory.dart';
import 'package:me_medical_app/models/stockList.dart';

class EditStock extends StatefulWidget {
  const EditStock({Key? key}) : super(key: key);

  @override
  _EditStockState createState() => _EditStockState();
}

class _EditStockState extends State<EditStock> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'add to stock',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
