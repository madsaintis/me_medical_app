import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_medical_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String phone, String email,
      String password, String location) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone': phone,
      'Email': email,
      'Password': password,
      'Clinic Location': location
    });
  }

  //update profile
  Future updateProfile(
      String name, String phone, String email, String location) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone': phone,
      'Email': email,
      'Clinic Location': location
    });
  }

  //User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['Name'],
      phone: snapshot['Phone'],
      email: snapshot['Email'],
      location: snapshot['Location'],
      password: snapshot['Password'],
    );
  }

  //get user data
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
