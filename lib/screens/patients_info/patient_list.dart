// ignore_for_file: prefer_const_constructors

import 'package:me_medical_app/screens/patients_info/patient_previous_visits.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/dashboard/dashboard.dart';
import 'package:me_medical_app/services/database.dart';

// ignore: use_key_in_widget_constructors
class PatientListPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  TextEditingController editingController = TextEditingController();
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore
        .collection("patients")
        .doc(AuthService().getCurrentUID())
        .collection('patientInfo')
        .get();

    return qn.docs;
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Patient Information"),
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
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        autofocus: false,
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
                                                        .data()["Patient Name"],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                trailing: Wrap(
                                                  children: [
                                                    Text(
                                                        snapshot.data[index]
                                                            .data()["IC"],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                                onTap: () {
                                                  editingController.clear();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PatientDetailPage(
                                                                patientInfo:
                                                                    snapshot.data[
                                                                        index],
                                                              )));
                                                }))));
                              } else if (snapshot.data[index]["Patient Name"]
                                      .toLowerCase()
                                      .contains(editingController.text) ||
                                  snapshot.data[index]["IC"]
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
                                                        .data()["Patient Name"],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                trailing: Wrap(
                                                  children: [
                                                    Text(
                                                        snapshot.data[index]
                                                            .data()["IC"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                                onTap: () {
                                                  editingController.clear();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PatientDetailPage(
                                                                patientInfo:
                                                                    snapshot.data[
                                                                        index],
                                                              )));
                                                }))));
                              } else {
                                return Container();
                              }
                            }))
                  ],
                );
              }
            }));
  }
}

class PatientDetailPage extends StatefulWidget {
  final DocumentSnapshot? patientInfo;

  PatientDetailPage({this.patientInfo});

  @override
  _PatientDetailPageState createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  final _formKey = GlobalKey<FormState>();

  String patientName = '';
  String ic = '';
  String gender = '';
  String contactNumber = '';
  String bod = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.patientInfo!['Patient Name'],
              overflow: TextOverflow.ellipsis),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientListPage()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DatabaseService(uid: AuthService().getCurrentUID())
                    .deleteItem(widget.patientInfo!.id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientListPage()));
              },
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(
                left: 30.0, right: 20.0, top: 20.0, bottom: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.patientInfo!['Patient Name'],
                      onChanged: (val) {
                        setState(() => patientName = val);
                      },
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Patient name field can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Patient Name",
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
                      initialValue: widget.patientInfo!['IC'],
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "IC field can't be empty";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => ic = val);
                      },
                      decoration: InputDecoration(
                          labelText: "IC",
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
                      initialValue: widget.patientInfo!['Gender'],
                      onChanged: (val) {
                        setState(() => gender = val);
                      },
                      decoration: InputDecoration(
                          labelText: "Gender",
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
                      initialValue: widget.patientInfo!['BOD'],
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Birth date field can't be empty";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => contactNumber = val);
                      },
                      decoration: InputDecoration(
                          labelText: "BOD",
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
                      initialValue: widget.patientInfo!['ContactNumber'],
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Contact number field can't be empty";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => contactNumber = val);
                      },
                      decoration: InputDecoration(
                          labelText: "Contact Number",
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
                      initialValue: widget.patientInfo!['address'],
                      validator: (String? val) {
                        if (val != null && val.isEmpty) {
                          return "Address field can't be empty";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => contactNumber = val);
                      },
                      decoration: InputDecoration(
                          labelText: "Address",
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
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 20.0, 30.0, 0),
                        child: TextButton.icon(
                            icon: Icon(Icons.add),
                            label: Text(
                              'Check previous visits',
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PatientPreviousCheckUp(
                                              widget.patientInfo!['IC'])));
                            })),
                  ],
                ))));
  }
}
