import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_medical_app/models/user.dart';
import 'package:me_medical_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  TheUser? _userFirebase(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<TheUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFirebase(user!));
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future logIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future register(
      String name, String phone, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //Create a new document for the new user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData(name, phone, email, password, '');
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //edit profile
  Future editProfile(
      String name, String phone, String email, String location) async {
    try {
      User? user = _auth.currentUser;

      //Create a new document for the new user with the uid
      await DatabaseService(uid: user!.uid)
          .updateProfile(name, phone, email, location);
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //add item
  Future addItem(String itemName, String buyPrice, String sellPrice,
      String inStock) async {
    try {
      final User? user = _auth.currentUser;

      //Create a new document for the new user with the uid
      await DatabaseService(uid: user!.uid)
          .updateItemInventory(itemName, buyPrice, sellPrice, inStock);
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addPatient(String patientName, String ic, String bod, String gender,
      String contactNumber, String address) async {
    try {
      final User? user = _auth.currentUser;

      //Create a new document for the new user with the uid
      await DatabaseService(uid: user!.uid)
          .updatePatient(patientName, ic, bod, gender, contactNumber, address);
      return _userFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //get current UID
  String getCurrentUID() {
    return _auth.currentUser!.uid;
  }

  //get current user
  Future getCurrentUser() async {
    return _auth.currentUser;
  }
}
