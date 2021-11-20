import 'package:flutter/material.dart';
import 'package:me_medical_app/login_page.dart';
import 'package:me_medical_app/models/user.dart';
import 'package:me_medical_app/register.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/sign_in.dart';
import 'package:me_medical_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'edit_profile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      initialData: null,
      catchError: (User, TheUser) => null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Firebase',
        home: SignIn2(),
      ),
    );
  }
}
