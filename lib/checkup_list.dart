import 'package:me_medical_app/add_item.dart';
import 'package:me_medical_app/add_stock.dart';
import 'package:me_medical_app/checkup_details.dart';
import 'package:me_medical_app/patient_checkup.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class CheckUpList extends StatefulWidget {
  @override
  _CheckUpListState createState() => _CheckUpListState();
}

class _CheckUpListState extends State<CheckUpList> {
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore
        .collection("checkup")
        .doc(AuthService().getCurrentUID())
        .collection('checkUpInfo')
        .get();

    return qn.docs;
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Check Up List"),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientCheckUp()));
            },
          ),
        ),
        body: FutureBuilder(
            future: getPosts(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      if (snapshot.data!.length == 0) {
                        return Center(
                          child: Text("Your inventory is empty :("),
                        );
                      }
                      return Container(
                        child: ListTile(
                            title: Text(
                                snapshot.data[index].data()["Patient Name"]),
                            trailing: Wrap(
                              children: [
                                Text("Date: " +
                                    snapshot.data[index]
                                        .data()["Date"]
                                        .toString())
                              ],
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckUpDetail(
                                          patientName: snapshot.data[index]
                                              .data()["Patient Name"],
                                          patientIC:
                                              snapshot.data[index].data()["IC"],
                                          date: snapshot.data[index]
                                              .data()["Date"],
                                          medicine: snapshot.data[index]
                                              .data()["Medications"]
                                              .cast<String>(),
                                          description: snapshot.data[index]
                                              .data()["Description"],
                                        )))),
                        decoration:
                            BoxDecoration(border: Border(bottom: BorderSide())),
                      );
                    });
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
