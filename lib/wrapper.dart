import 'package:flutter/material.dart';
import 'package:me_medical_app/authenticate.dart';
import 'package:me_medical_app/dashboard.dart';
import 'package:me_medical_app/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Dashboard();
    }
  }
}
