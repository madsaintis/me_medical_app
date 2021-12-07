// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:me_medical_app/inventory.dart';
import 'package:me_medical_app/services/auth.dart';

// ignore: use_key_in_widget_constructors
class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String itemName = '';
  String buyPrice = '';
  String sellPrice = '';
  String inStock = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Item"),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InventoryPage()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(
                left: 30.0, right: 20.0, top: 20.0, bottom: 20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    onChanged: (val) {
                      setState(() => itemName = val);
                    },
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Item name field can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Item Name",
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
                        return "Buy price field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => buyPrice = val);
                    },
                    decoration: InputDecoration(
                        labelText: "Buy Price",
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
                    onChanged: (val) {
                      setState(() => sellPrice = val);
                    },
                    decoration: InputDecoration(
                        labelText: "Sell Price",
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
                      setState(() => inStock = val);
                    },
                    decoration: InputDecoration(
                        labelText: "In Stock",
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
                          child: Text("Add Item"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _auth.addItem(
                                  itemName, buyPrice, sellPrice, inStock);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InventoryPage()));
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber))),
                  SizedBox(
                    height: 25.0,
                  ),
                ]))));
  }
}
