// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/checkup_pages/patient_checkup.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String patientName = '';
  String ic = '';
  String bod = '';
  DateTime date = DateTime.now();
  String gender = '';
  String contactNumber = '';
  String address = '';

  Future pickDate() async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now());
    if (newDate == null) return;
    setState(() => date = newDate);
  }

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
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
              Navigator.push(
                  context,
                  //should jump to the main patient page...
                  MaterialPageRoute(builder: (context) => PatientCheckUp()));
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(
                left: 30.0, right: 20.0, top: 20.0, bottom: 20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    onChanged: (val) {
                      setState(() => patientName = val);
                    },
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Name field can't be empty";
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
                        return "Patient ID field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => ic = val);
                    },
                    decoration: InputDecoration(
                        labelText: "Patient ID",
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
                    controller: _textEditingController,
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Name field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => bod = val);
                    },
                    decoration: InputDecoration(
                        labelText: "Birth Date",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[200]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // Show Date Picker Here
                      await pickDate();

                      _textEditingController.text =
                          DateFormat('yyyy/MM/dd').format(date);
                      bod = DateFormat('yyyy/MM/dd').format(date).toString();
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _textEditingController2,
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "Name field can't be empty";
                      }
                      return null;
                    },
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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                      title: Text("Male"),
                                      onTap: () {
                                        setState(() {
                                          gender = "Male";
                                          Navigator.pop(context);
                                          _textEditingController2.text = gender;
                                        });
                                      }),
                                  ListTile(
                                      title: Text("Female"),
                                      onTap: () {
                                        setState(() {
                                          gender = "Female";
                                          Navigator.pop(context);
                                          _textEditingController2.text = gender;
                                        });
                                      })
                                ]);
                          });
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
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
                    validator: (String? val) {
                      if (val != null && val.isEmpty) {
                        return "address field can't be empty";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => address = val);
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
                              _auth.addPatient(patientName, ic, bod, gender,
                                  contactNumber, address);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //this need to change later
                                      builder: (context) => PatientCheckUp()));
                            }
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber))),
                  SizedBox(
                    height: 25.0,
                  ),
                ]))));
  }
}
