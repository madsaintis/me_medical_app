import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:me_medical_app/models/user.dart';

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

  //sign in anynimous
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
    //sign in with email & password

    // register with email & password

    // sign out
    Future signOut() async {
      try {
        return await _auth.signOut();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }
}
