// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:me_medical_app/models/user.dart';
import 'package:me_medical_app/services/auth.dart';
import 'package:me_medical_app/services/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

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
      catchError: (User, theUser) => null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],

          // Define the default font family.
          fontFamily: GoogleFonts.montserrat().fontFamily,

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            bodyText1:
                TextStyle(fontFamily: GoogleFonts.comicNeue().fontFamily),
            bodyText2: const TextStyle(),
          ).apply(
            bodyColor: Colors.orange,
            displayColor: Colors.blue,
          ),
        ),
        title: 'Flutter Firebase',
        home: Wrapper(),
      ),
    );
  }
}
