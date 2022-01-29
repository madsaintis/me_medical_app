// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:me_medical_app/screens/checkup_pages/add_patient.dart';
import 'package:me_medical_app/screens/checkup_pages/checkup_details.dart';
import 'package:intl/intl.dart';
import 'package:me_medical_app/screens/checkup_pages/checkup_list.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/dashboard/dashboard.dart';
import 'package:me_medical_app/services/database.dart';

// ignore: use_key_in_widget_constructors
class PatientCheckUp extends StatefulWidget {
  @override
  PatientCheckUpState createState() => PatientCheckUpState();
}

class PatientCheckUpState extends State<PatientCheckUp> {
  void refresh() {
    setState(() {});
  }

  final Stream<QuerySnapshot> itemStream = FirebaseFirestore.instance
      .collection('items')
      .doc(AuthService().getCurrentUID())
      .collection('itemInfo')
      .snapshots();

  final Stream<QuerySnapshot> patientStream = FirebaseFirestore.instance
      .collection('patients')
      .doc(AuthService().getCurrentUID())
      .collection('patientInfo')
      .snapshots();
//!
  final Stream<QuerySnapshot> incomeStream = FirebaseFirestore.instance
      .collection('income')
      .doc(AuthService().getCurrentUID())
      .collection('profits')
      .snapshots();

  List<DropdownMenuItem> patients = [];
  List<DropdownMenuItem> items = [];

//!
  double newProfit = 0;
  String? description = "";
  String? value = "Not Available";
  String? selectedPatient;
  String? patientIC;
  String? patientName;
  String? patientHint;
  List<CartItem> cart = [];
  List<String> medicine = [];
  List<String> medName = [];
  List<String> medQuantity = [];
  bool isButtonActive = false;
  final AuthService _auth = AuthService();

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Patient Check Up"),
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
            stream: itemStream,
            builder: (context, snapshot) {
              return StreamBuilder<QuerySnapshot>(
                  stream: patientStream,
                  builder: (context, snapshot2) {
                    if (!snapshot.hasData || !snapshot2.hasData) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else {
                      if (snapshot.data!.size == 0) {
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
                                value: snap['Item Name'] +
                                    " " +
                                    snap.id +
                                    " " +
                                    snap['In Stock'].toString(),
                              ),
                            );
                          }
                        }
                      }
                      if (snapshot2.data!.size == 0) {
                        patientHint = "No patients found";
                      } else {
                        patientHint = "Select a patient";
                        if (patients.isEmpty) {
                          for (int i = 0;
                              i < snapshot2.data!.docs.length;
                              i++) {
                            DocumentSnapshot snap = snapshot2.data!.docs[i];
                            patients.add(
                              DropdownMenuItem(
                                child: Text(
                                  snap['Patient Name'] + " - " + snap['IC'],
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                                value: snap['IC'] + " " + snap['Patient Name'],
                              ),
                            );
                          }
                        }
                      }
                      return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
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
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: InputDecorator(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder()),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<dynamic>(
                                                value: selectedPatient,
                                                items: patients,
                                                isDense: true,
                                                onChanged: (val) {
                                                  setState(() {
                                                    isButtonActive = true;
                                                    selectedPatient = val;
                                                  });
                                                },
                                                hint: Text(patientHint!))))),
                                Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 30.0, top: 10.0, bottom: 30.0),
                                    child: Text("Medications",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 20.0, top: 10.0),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        key: UniqueKey(),
                                        itemCount: cart.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return CartWidget(
                                              cart: cart,
                                              index: index,
                                              callback: refresh,
                                              items: items);
                                        }),
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 20.0, 30.0, 0),
                                        child: TextButton.icon(
                                          icon: Icon(Icons.add),
                                          label: Text(
                                            'Add Row',
                                          ),
                                          onPressed: isButtonActive
                                              ? () {
                                                  setState(() {});
                                                  cart.add(CartItem(
                                                      itemID: "",
                                                      itemName: "",
                                                      quantity: "",
                                                      itemStock: ""));
                                                }
                                              : null,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 10.0, 30.0, 30.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Description",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          TextField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLength: null,
                                            maxLines: null,
                                            onChanged: (value) =>
                                                description = value,
                                          ),
                                        ])),
                                Center(
                                    child: ElevatedButton(
                                        child: Text("Confirm Check Up"),
                                        onPressed: isButtonActive
                                            ? () async {
                                                setState(() {});
                                                for (int i = 0;
                                                    i < cart.length;
                                                    i++) {
                                                  medName.add(
                                                      cart[i].itemName! +
                                                          " " +
                                                          cart[i].quantity!);
                                                  medicine.add(cart[i].itemID! +
                                                      " " +
                                                      cart[i].itemName! +
                                                      " " +
                                                      cart[i].quantity! +
                                                      " " +
                                                      cart[i].itemStock!);
                                                  medQuantity
                                                      .add(cart[i].quantity!);
                                                }
                                                newProfit = newProfit + 50;
                                                await DatabaseService(
                                                        uid: AuthService()
                                                            .getCurrentUID())
                                                    .updateIncome(newProfit);

                                                _auth.updateInventory(medicine);
                                                patientIC = selectedPatient!
                                                    .split(" ")[0];
                                                patientName = selectedPatient!
                                                    .split(" ")[1];

                                                await DatabaseService(
                                                        uid: AuthService()
                                                            .getCurrentUID())
                                                    .updateCheckUpList(
                                                        patientName!,
                                                        patientIC!,
                                                        DateFormat(
                                                                'yyyy/MM/dd hh:mm a')
                                                            .format(
                                                                DateTime.now())
                                                            .toString(),
                                                        medName,
                                                        description!);

                                                await DatabaseService(
                                                        uid: AuthService()
                                                            .getCurrentUID())
                                                    .updatePatientCheckUpList(
                                                        patientName!,
                                                        patientIC!,
                                                        DateFormat(
                                                                'yyyy/MM/dd hh:mm a')
                                                            .format(
                                                                DateTime.now())
                                                            .toString(),
                                                        medName,
                                                        description!);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CheckUpDetail(
                                                                patientName:
                                                                    patientName,
                                                                patientIC:
                                                                    patientIC,
                                                                date: DateFormat(
                                                                        'yyyy/MM/dd hh:mm a')
                                                                    .format(
                                                                        DateTime
                                                                            .now())
                                                                    .toString(),
                                                                medicine:
                                                                    medName,
                                                                description:
                                                                    description)));
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.amber))),
                              ],
                            ),
                          ));
                    }
                  });
            }),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                  heroTag: null,
                  elevation: 10.0,
                  label: Text('Add Patient'),
                  icon: Icon(Icons.add),
                  backgroundColor: Color(0xFFE57373),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPatientPage()));
                  }),
              SizedBox(
                height: 20.0,
              ),
              FloatingActionButton.extended(
                  heroTag: null,
                  elevation: 10.0,
                  label: Text('Check Up History'),
                  icon: Icon(Icons.list),
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CheckUpList()));
                  })
            ]));
  }
}

class Quantity extends StatefulWidget {
  CartItem? cartItem;

  Quantity({Key? key, this.cartItem}) : super(key: key);
  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(Quantity oldWidget) {
    if (oldWidget.cartItem!.quantity != widget.cartItem!.quantity) {}
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        onChanged: (String? value) {
          setState(() {
            widget.cartItem!.quantity = value;
          });
        });
  }
}

class Medicine extends StatefulWidget {
  List<DropdownMenuItem> items = [];

  CartItem? cartItem;

  Medicine({Key? key, this.cartItem, required this.items}) : super(key: key);
  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  String? _value;
  List<DropdownMenuItem> itemsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(Medicine oldWidget) {
    if (oldWidget.cartItem!.itemName != widget.cartItem!.itemName) {
      super.didUpdateWidget(oldWidget);
    }
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
                  widget.cartItem!.itemName = _value!.split(" ")[0];
                  widget.cartItem!.itemID = _value!.split(" ")[1];
                  widget.cartItem!.itemStock = _value!.split(" ")[2];
                });
              })),
    );
  }
}

class CartItem {
  String? itemID;
  String? itemName;
  String? itemStock;
  String? quantity;
  CartItem({this.itemID, this.itemName, this.quantity, this.itemStock});
}

class CartWidget extends StatefulWidget {
  List<DropdownMenuItem> items;
  List<CartItem>? cart;
  int? index;
  VoidCallback? callback;

  CartWidget(
      {Key? key, this.cart, this.index, this.callback, required this.items})
      : super(key: key);
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
                child: Medicine(
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
