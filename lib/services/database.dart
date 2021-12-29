import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_medical_app/stockList.dart';
import 'package:me_medical_app/models/user.dart';
import 'package:me_medical_app/services/auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

//! maaaa
  final CollectionReference stockCollection =
      FirebaseFirestore.instance.collection('stocks');

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
    //!maaaaaaaaa
    updateStock(itemName, int.parse(buyPrice), int.parse(stock));
    return await itemCollection.doc(uid).collection('itemInfo').add({
      'Item Name': itemName,
      'Buy Price': buyPrice,
      'Sell Price': sellPrice,
      'In Stock': stock,
      'User ID': uid,
    });
  }

//!maaaaaaaaa
  Future updateStock(String itemName, int buyPrice, int stock) async {
    return await stockCollection.doc(uid).set({
      'Item Name': itemName,
      'Buy Price': buyPrice,
      'In Stock': stock,
      'User ID': uid,
    });
  }

  //!maaaaaaaaa
  Future deleteStock() async {
    return await stockCollection.doc(uid).delete();
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

//!maaaaaaaa
  List<Stock> _stockListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var a = doc.data() as Map;
      return Stock(
          name: a['Item Name'] ?? '',
          inStock: a['In Stock'] ?? 0,
          buyPrice: a['Buy Price'] ?? 0);
    }).toList();
  }

//!maaaaaaa
  Stream<List<Stock>> get stocks {
    return stockCollection.snapshots().map(_stockListFromSnapshot);
  }
}
