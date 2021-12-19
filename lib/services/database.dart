import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:me_medical_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future updateUserData(String name, String phone, String email,
      String password, String location) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone': phone,
      'Email': email,
      'Password': password,
      'Clinic Location': location,
      'User ID': uid
    });
  }

  //update item
  Future updateItemInventory(
      String itemName, String buyPrice, String sellPrice, String stock) async {
    return await itemCollection.doc(uid).collection('itemInfo').add({
      'Item Name': itemName,
      'Buy Price': buyPrice,
      'Sell Price': sellPrice,
      'In Stock': stock,
      'User ID': uid,
    });
  }

  //update user's patient list    !! FIX THIS !!
  Future updatePatientInventory(
      String PatientName, String IC, String BOD, String Gender,String ContactNumber,String address) async {
    return await itemCollection.doc(uid).collection('itemInfo').add({
      'Patient Name': PatientName,
      'IC': IC,
      'BOD': BOD,
      'Gender': Gender,
      'ContactNumber': ContactNumber,
      'address':address,
      'User ID':uid,
    });
  }
  
  //update profile
  Future updateProfile(
      String name, String phone, String email, String location) async {
    return await userCollection.doc(uid).update({
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

  //delete item
  Future deleteItem(String itemID) async {
    return await itemCollection
        .doc(uid)
        .collection('itemInfo')
        .doc(itemID)
        .delete();
  }

  //get user data
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
