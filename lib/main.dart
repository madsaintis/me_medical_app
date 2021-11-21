// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:me_medical_app/models/user.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/wrapper.dart';
import 'package:provider/provider.dart';
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
        home: Wrapper(),
      ),
    );
  }
}
