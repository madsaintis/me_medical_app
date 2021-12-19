// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:me_medical_app/inventory.dart';
import 'package:me_medical_app/services/auth.dart';

// ignore: use_key_in_widget_constructors
class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String PatientName = '';
  String IC = '';
  String BOD='';
  DateTime date=DateTime.now();
  String Gender = '';
  String ContactNumber = '';
  String Address = '';

  Future pickDate() async{
    final initialDate=DateTime.now();
    final newDate=await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime (DateTime.now().year-100), lastDate: DateTime(DateTime.now().year)
    );
    if(newDate==null) return;
    setState(()=>date=newDate);
  }

    String getText(){
    if(date==null){
      return 'Select Date';
    }
    else{
      return '&{date.month}/&{date.day}/${date.year}';
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Add Patient"),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  //should jump to the main patient page...
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
                      setState(() => PatientName = val);
                    },
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Item name field can't be empty";
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
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Buy price field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => IC = val);
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
                    onChanged: (val) {
                      setState(() => BOD = val);
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
                    onTap:(){
                      pickDate();
                      BOD=getText();
                    } ,
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
                      setState(() => Gender = val);
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
                        )
                    ),
                    onTap: (){
                      showBottomSheet(context: context, builder:(BuildContext context){
                        return Column(mainAxisSize:MainAxisSize.min,
                        children:<Widget>[
                          ListTile(
                          title:Text("man"),
                          onTap: () {
                            setState(() {
                              Gender = "man";
                              Navigator.pop(context);
                            });
                          }),
                          ListTile(
                              title:Text("women"),
                              onTap: () {
                                setState(() {
                                  Gender = "women";
                                  Navigator.pop(context);
                                });
                              })
                        ]
                        );
                      });
                    },
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
                      setState(() => ContactNumber = val);
                    },
                    decoration: InputDecoration(
                        labelText: "ContactNumber",
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
                      setState(() => Address = val);
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
                  Center(
                      child: ElevatedButton(
                          child: Text("Add Patient"),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _auth.addPatient(
                                  PatientName,IC,BOD,Gender,ContactNumber,Address);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                //this need to change later
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
