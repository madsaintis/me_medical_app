import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_medical_app/screens/profile_pages/view_profile.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/services/wrapper.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final _newpasswordController = TextEditingController();
  final _repeatpasswordController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('User ID', isEqualTo: AuthService().getCurrentUID())
      .snapshots();
  final AuthService _auth = AuthService();
  String name = '';
  String phone = '';
  String location = '';
  int status = 0;
  String password = '';
  String newpassword = '';
  String confirmnewpassword = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile"),
          backgroundColor: Colors.teal,
          elevation: 3,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => ViewProfilePage(),
                ),
                (route) =>
                    true, //if you want to disable back feature set to false
              );
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading"));
              } else {
                return Column(children: <Widget>[
                  // construct the profile details widget here
                  const SizedBox(
                    height: 20,
                  ),

                  // the tab bar with two items
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 70.0,
                    child: AppBar(
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              "Change Information",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // create widgets for each tab bar here
                  Expanded(
                    child: TabBarView(
                      children: [
                        // first tab bar view widget
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                          child: Center(
                              child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              name = data['Name'];

                              phone = data['Phone'];
                              location = data['Clinic Location'];

                              return Form(
                                  key: _formKey,
                                  child: Column(children: <Widget>[
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      initialValue: name,
                                      onChanged: (val) => name = val,
                                      validator: (String? val) {
                                        if (val != null && val.isEmpty) {
                                          return "Name field can't be empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Full Name ",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[200]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      validator: (String? val) {
                                        if (val != null && val.isEmpty) {
                                          return "Phone field can't be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (val) => phone = val,
                                      initialValue: data['Phone'],
                                      decoration: InputDecoration(
                                          labelText: "Phone Number",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[200]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      onChanged: (val) => location = val,
                                      initialValue: data['Clinic Location'],
                                      decoration: InputDecoration(
                                          labelText: "Clinic Location",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[200]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Center(
                                        child: ElevatedButton(
                                            child: const Text(
                                                "Change Information"),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() => error =
                                                    'Changed successfully');
                                                await _auth.editProfile(
                                                    name, phone, location);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProfile()));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.amber))),
                                  ]));
                            }).toList(),
                          )),
                        ),

                        // second tab bar viiew widget
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                          child: Center(
                              child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return Form(
                                  key: _formKey2,
                                  child: Column(children: <Widget>[
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      controller: _newpasswordController,
                                      onChanged: (val) => newpassword = val,
                                      validator: (String? val) {
                                        if (val != null && val.isEmpty) {
                                          return "New password field can't be empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "New Password ",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[200]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      controller: _repeatpasswordController,
                                      validator: (value) {
                                        return _newpasswordController.text ==
                                                value
                                            ? null
                                            : "Please validate your entered password";
                                      },
                                      onChanged: (val) =>
                                          confirmnewpassword = val,
                                      decoration: InputDecoration(
                                          labelText: "Confirm New Password",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[200]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      onChanged: (val) => password = val,
                                      validator: (String? val) {
                                        if (val != null && val.isEmpty) {
                                          return "Current password field can't be empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Current Password ",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[200]),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    Center(
                                        child: ElevatedButton(
                                            child:
                                                const Text("Change Password"),
                                            onPressed: () async {
                                              if (_formKey2.currentState!
                                                  .validate()) {
                                                setState(() => error =
                                                    'Changed successfully');
                                                _changePassword(
                                                    password,
                                                    _newpasswordController
                                                        .text);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.amber))),
                                  ]));
                            }).toList(),
                          )),
                        ),
                      ],
                    ),
                  ),
                ]);
              }
            }),
      ),
    );
  }

  void _changePassword(String currentPassword, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user!.email.toString();
    print(currentPassword + newPassword);

    final cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      }).catchError((error) {
        //Error, show something
      });
    }).catchError((err) {});
  }
}
