// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:me_medical_app/screens/inventory/add_item.dart';
import 'package:me_medical_app/screens/inventory/add_stock.dart';
import 'package:me_medical_app/screens/dashboard/dashboard.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/services/database.dart';

// ignore: use_key_in_widget_constructors
class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  TextEditingController editingController = TextEditingController();
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore
        .collection("items")
        .doc(AuthService().getCurrentUID())
        .collection('itemInfo')
        .get();

    return qn.docs;
  }

  @override
  void initState() {
    super.initState();
  }

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
        body: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Your inventory is empty :("),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (editingController.text.isEmpty) {
                                return SizedBox(
                                    height: 80.0,
                                    child: Card(
                                        margin: EdgeInsets.all(10),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: ListTile(
                                              title: Text(
                                                  snapshot.data[index]
                                                      .data()["Item Name"],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              trailing: Wrap(
                                                children: [
                                                  Text(
                                                      snapshot.data[index]
                                                          .data()["In Stock"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ItemDetailPage(
                                                            itemInfo: snapshot
                                                                .data[index],
                                                          ))),
                                            ))));
                              } else if (snapshot.data[index]["Item Name"]
                                  .toLowerCase()
                                  .contains(editingController.text)) {
                                return SizedBox(
                                    height: 80.0,
                                    child: Card(
                                        margin: EdgeInsets.all(10),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: ListTile(
                                              title: Text(
                                                  snapshot.data[index]
                                                      .data()["Item Name"],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              trailing: Wrap(
                                                children: [
                                                  Text(
                                                      snapshot.data[index]
                                                          .data()["In Stock"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ItemDetailPage(
                                                            itemInfo: snapshot
                                                                .data[index],
                                                          ))),
                                            ))));
                              } else {
                                return Container();
                              }
                            }))
                  ],
                );
                /*ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return Container(
                          height: 80.0,
                          child: Card(
                            margin: EdgeInsets.all(10),
                            child: Align(
                                alignment: Alignment.center,
                                child: ListTile(
                                    dense: true,
                                    title: Text(
                                        snapshot.data[index]
                                            .data()["Item Name"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    trailing: Wrap(
                                      children: [
                                        Text(
                                            snapshot.data[index]
                                                .data()["In Stock"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                    FontWeight.bold))
                                      ],
                                    ),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemDetailPage(
                                                  itemInfo:
                                                      snapshot.data[index],
                                                ))))),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                          ));
                    });*/
              }
            }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                  heroTag: "btn2",
                  elevation: 0.0,
                  label: Text('Add Item'),
                  icon: Icon(Icons.add),
                  backgroundColor: Color(0xFFE57373),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddItemPage()));
                  }),
            ),
            //!maaaaaaaa{
            FloatingActionButton.extended(
                heroTag: "btn1",
                elevation: 0.0,
                label: Text('Add Stock'),
                icon: Icon(Icons.add),
                backgroundColor: Color(0xFFE57373),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddStockPage()));
                }),
            //! maaaaaaaaaa}
          ],
        ));
  }
}

class ItemDetailPage extends StatefulWidget {
  final DocumentSnapshot? itemInfo;

  ItemDetailPage({this.itemInfo});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
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
          title: Text(widget.itemInfo!['Item Name'],
              overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              /*
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InventoryPage()));*/
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DatabaseService(uid: AuthService().getCurrentUID())
                    .deleteItem(widget.itemInfo!.id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InventoryPage()));
              },
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
                    initialValue: widget.itemInfo!['Item Name'],
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
                    initialValue: widget.itemInfo!['Buy Price'],
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
                    initialValue: widget.itemInfo!['Sell Price'],
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
                    initialValue: widget.itemInfo!['In Stock'].toString(),
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
                ]))));
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