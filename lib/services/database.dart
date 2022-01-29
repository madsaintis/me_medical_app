import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:me_medical_app/screens/dashboard/chart.dart';
import 'package:me_medical_app/screens/inventory/stockList.dart';
import 'package:me_medical_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patients');

  final CollectionReference checkUpCollection =
      FirebaseFirestore.instance.collection('checkup');

  final CollectionReference stockCollection =
      FirebaseFirestore.instance.collection('stocks');

  final CollectionReference incomeCollection =
      FirebaseFirestore.instance.collection('income');

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

  //update user's patient list
  Future updatePatient(String patientName, String ic, String bod, String gender,
      String contactNumber, String address) async {
    return await patientCollection
        .doc(uid)
        .collection('patientInfo')
        .doc(ic)
        .set({
      'Patient Name': patientName,
      'IC': ic,
      'BOD': bod,
      'Gender': gender,
      'ContactNumber': contactNumber,
      'address': address,
    });
  }

  Future updateCheckUpList(String patientName, String ic, String date,
      List<String> medicine, String description) async {
    return await checkUpCollection.doc(uid).collection('checkUpInfo').add({
      'Patient Name': patientName,
      'IC': ic,
      'Date': date,
      'Medications': medicine,
      'Description': description,
    });
  }

  Future updatePatientCheckUpList(String patientName, String ic, String date,
      List<String> medicine, String description) async {
    return await patientCollection
        .doc(uid)
        .collection('patientInfo')
        .doc(ic)
        .collection('patientCheckUpInfo')
        .add({
      'Patient Name': patientName,
      'IC': ic,
      'Date': date,
      'Medications': medicine,
      'Description': description,
    });
  }

  // Decrement medicine stock after check up
  Future updateStockAfterCheckUp(String? docID, int decrementStock) async {
    //!
    var soldMed =
        await itemCollection.doc(uid).collection('itemInfo').doc(docID).get();

    final int price = int.parse(soldMed.data()?["Sell Price"]);
    final int inStock = int.parse(soldMed.data()?["In Stock"]);
    final int medQuantity = inStock - decrementStock;
    final double medPrice = (price * medQuantity).toDouble();
    updateIncome(medPrice);

    return await itemCollection
        .doc(uid)
        .collection('itemInfo')
        .doc(docID)
        .update({"In Stock": decrementStock});
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
  Future updateProfile(String name, String phone, String location) async {
    return await userCollection
        .doc(uid)
        .update({'Name': name, 'Phone': phone, 'Clinic Location': location});
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

  //! ma

  // ChartData _profitDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return ChartData(day: snapshot['date'], income: snapshot['profit']);
  // }
//! ma
  List<ChartData> _profitListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var a = doc.data() as Map;
      return ChartData(
        month: a['date'] ?? '',
        income: a['profit'].round() ?? 0.0,
      );
    }).toList();
  }

//! ma
  Stream<List<ChartData>> get profits {
    return incomeCollection
        .doc(uid)
        .collection('profit')
        .snapshots()
        .map(_profitListFromSnapshot);
  }

//! ma
  Future updateIncome(double newProfit) async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);

    var currProfitSnapshot = await FirebaseFirestore.instance
        .collection('income')
        .doc(uid)
        .collection('profit')
        .doc(date.toString())
        .get();

    final double currProfit = currProfitSnapshot.data()?['profit'] ?? 0.0;
    newProfit += currProfit;

    return await incomeCollection
        .doc(uid)
        .collection('profit')
        .doc(date.toString())
        .set({
      'profit': newProfit,
      'date': date,
    });
  }
}
