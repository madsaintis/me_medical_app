import 'package:flutter/material.dart';
import 'package:me_medical_app/services/auth.dart';

class SignIn2 extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn2> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //define usename input
    final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (val) {},
      decoration: InputDecoration(
          hintText: 'Username',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            gapPadding: 5,
          )),
    );

    //define the password
    final password = TextFormField(
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            gapPadding: 5,
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo(),
            SizedBox(
              height: 20.0,
            ),
            logoword(),
            SizedBox(
              height: 20.0,
            ),
            username,
            SizedBox(
              height: 8.0,
            ),
            password,
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [RegisterText()],
            ),
            LogButton(),
          ],
        ),
      ),
    );
  }
}

//logo picture
class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircleAvatar(
      radius: 64,
      backgroundImage: AssetImage('assets/images/icon1.png'),
      backgroundColor: Colors.transparent,
    ));
  }
}

//logo word
class logoword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Login",
      style: TextStyle(
        color: Colors.black87,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ));
  }
}

//ForgetWord
class RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterButton = TextButton(
      onPressed: () {},
      child: Text(
        'Register',
        style: TextStyle(color: Colors.blue, fontSize: 12),
        textAlign: TextAlign.right,
      ),
    );
    return RegisterButton;
  }
}

//class logbutton
class LogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: MaterialButton(
              minWidth: 80.0,
              height: 40.0,
              //later implement the jump page function
              onPressed: () {},
              color: Colors.lightBlueAccent,
              child: Text(
                'Log in',
                style: TextStyle(fontSize: 30),
              )),
        ));
    return loginButton;
  }
}
