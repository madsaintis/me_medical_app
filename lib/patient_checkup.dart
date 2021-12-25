// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:me_medical_app/add_patient.dart';

import 'package:me_medical_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/dashboard.dart';
import 'package:me_medical_app/services/database.dart';

// ignore: use_key_in_widget_constructors
class PatientCheckUp extends StatefulWidget {
  @override
  PatientCheckUpState createState() => PatientCheckUpState();
}

class PatientCheckUpState extends State<PatientCheckUp> {
  List<DropdownMenuItem> items = [];
  void refresh() {
    setState(() {});
  }

  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore
        .collection("items")
        .doc(AuthService().getCurrentUID())
        .collection('itemInfo')
        .get();

    return qn.docs;
  }

  List<CartItem>? cart = [];
  List<String>? medicine = [];
  String? description = "";
  String? value = "Not Available";

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Medical Check Up"),
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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('items')
                  .doc(AuthService().getCurrentUID())
                  .collection('itemInfo')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                else {
                  if (snapshot.data!.size == 0) {
                    items.add(DropdownMenuItem(
                      child: Text(
                        'Your inventory is empty',
                        style: TextStyle(color: Color(0xff11b719)),
                      ),
                      value: "-",
                    ));
                  } else {
                    if (items.isEmpty) {
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        items.add(
                          DropdownMenuItem(
                            child: Text(
                              snap['Item Name'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: snap['Item Name'],
                          ),
                        );
                      }
                    }
                  }
                  return Container(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(
                                left: 30.0, top: 20.0, bottom: 30.0),
                            child: Text("Patient Information",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        /*Expanded(
                        flex: 4,
                        child: DropdownButton<dynamic>(
                          isDense: true,
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              value = valueSelectedByUser as String?;
                            });
                          },
                          hint: Text('Choose a patient'),
                          items: items,
                        ),
                      ),*/
                        /*TextButton.icon(
                          icon: Icon(Icons.list_alt),
                          label: Text('Print',
                              style: TextStyle(color: Colors.white)),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                          ),
                          //later implement the jump page function
                          onPressed: () async {
                            print(value);
                            print(items.length);
                            await DatabaseService(
                                    uid: AuthService().getCurrentUID())
                                .updateStock(value, int.parse("3"));
                          },
                        ),*/

                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(
                                left: 30.0, top: 10.0, bottom: 30.0),
                            child: Text("Medications",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Row(children: const [
                              Expanded(
                                flex: 3,
                                child: Center(
                                    child: Text(
                                  "Medicine Name",
                                  style: TextStyle(fontSize: 16),
                                )),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                    child: Text(
                                  "Quantity",
                                  style: TextStyle(fontSize: 16),
                                )),
                              ),
                            ])),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                key: UniqueKey(),
                                itemCount: cart!.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return CartWidget(
                                      cart: cart,
                                      index: index,
                                      callback: refresh,
                                      items: items);
                                }),
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(0, 20.0, 30.0, 0),
                                child: TextButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text(
                                    'Add Row',
                                  ),
                                  onPressed: () {
                                    cart!.add(
                                        CartItem(itemName: "", quantity: ""));
                                    setState(() {});
                                  },
                                )),
                          ],
                        )),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Description",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLength: null,
                                    maxLines: null,
                                    onChanged: (value) => description = value,
                                  )
                                ]))
                      ],
                    ),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
            elevation: 10.0,
            label: Text('Add Patient'),
            icon: Icon(Icons.add),
            backgroundColor: Color(0xFFE57373),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPatientPage()));
            }));
  }
}

/*
floatingActionButton: FloatingActionButton.extended(
            elevation: 0.0,
            label: Text('Add Item'),
            icon: Icon(Icons.add),
            backgroundColor: Color(0xFFE57373),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddItemPage()));
            })
*/

class Quantity extends StatefulWidget {
  CartItem? cartItem;

  Quantity({this.cartItem});
  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  String? _value = "";

  @override
  void initState() {
    super.initState();
    _value = widget.cartItem!.quantity;
  }

  @override
  void didUpdateWidget(Quantity oldWidget) {
    if (oldWidget.cartItem!.quantity != widget.cartItem!.quantity) {
      _value = widget.cartItem!.quantity!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        onChanged: (String? value) {
          setState(() {
            widget.cartItem!.quantity = value as String?;
          });
        });
  }
}

class Pizza extends StatefulWidget {
  List<DropdownMenuItem> items = [];

  CartItem? cartItem;

  Pizza({this.cartItem, required this.items});
  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  String? _value;
  List<DropdownMenuItem> itemsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(Pizza oldWidget) {
    if (oldWidget.cartItem!.itemName != widget.cartItem!.itemName)
      super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
              value: _value,
              items: widget.items,
              isDense: true,
              onChanged: (value) {
                setState(() {
                  _value = value;
                  widget.cartItem!.itemName = _value;
                });
              })),
    );
  }
}

class CartItem {
  String? itemName;
  String? quantity;
  CartItem({this.itemName, this.quantity});
}

class CartWidget extends StatefulWidget {
  List<DropdownMenuItem> items;
  List<CartItem>? cart;
  int? index;
  VoidCallback? callback;

  CartWidget({this.cart, this.index, this.callback, required this.items});
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(45.0, 5.0, 10.0, 2.0),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Pizza(
                    cartItem: widget.cart![widget.index!],
                    items: widget.items)),
            SizedBox(
              height: 30,
              width: 40,
            ),
            Expanded(
                flex: 1,
                child: Quantity(cartItem: widget.cart![widget.index!])),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.cart!.removeAt(widget.index!);
                    widget.callback!();
                  });
                },
              ),
            )
          ],
        ));
  }
}
