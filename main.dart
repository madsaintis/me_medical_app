import 'package:flutter/material.dart';

//Login page
main() {
  runApp(App());
}

class LoginPage extends StatefulWidget {
  static String page = 'login-page';

  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //define usename input
    final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'username',
      decoration: InputDecoration(
          hintText: 'Please enter your username',
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
          hintText: 'Please enter your password',
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
              mainAxisAlignment:MainAxisAlignment.end,
              children:[
              ForgetWord()],
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
      backgroundImage: AssetImage('assets/icon1.png'),
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
class ForgetWord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ForgetButton = TextButton(
      onPressed: () {},
      child: Text(
        'Forget password?',
        style: TextStyle(color: Colors.blue, fontSize: 12),
        textAlign: TextAlign.right,
      ),
    );
    return ForgetButton;
  }
}

//class logbutton
class LogButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final loginButton=Padding(
      padding: EdgeInsets.symmetric(vertical:1.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child:MaterialButton(
          minWidth: 80.0,
          height:40.0,
          //later implement the jump page function
          onPressed:(){},
          color:Colors.lightBlueAccent,
          child: Text('Log in',style:TextStyle(fontSize:30),)
        ),
      )
    );
    return loginButton;
  }
}

//username
//Material implement
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
