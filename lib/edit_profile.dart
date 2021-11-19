import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.teal,
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
          padding:
              EdgeInsets.only(left: 30.0, right: 20.0, top: 20.0, bottom: 20.0),
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                initialValue: "Kassim",
                decoration: InputDecoration(
                    labelText: "Full Name ",
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
                initialValue: "user@yahoo.com",
                decoration: InputDecoration(
                    labelText: "Email",
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
                initialValue: "012-34567890",
                decoration: InputDecoration(
                    labelText: "Phone Number",
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
                initialValue: "Jalan Resak",
                decoration: InputDecoration(
                    labelText: "Clinic Location",
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
                      child: Text("Change Information"),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(primary: Colors.amber))),
              SizedBox(
                height: 25.0,
              ),
              Text(
                "Edit Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "New Password",
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
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Confirm New Password",
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
                height: 10.0,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Current Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[200]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
              SizedBox(
                height: 20.0,
              ),
              Center(
                  child: ElevatedButton(
                      child: Text("Change Password"),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(primary: Colors.green)))
            ],
          )),
    );
  }
}
