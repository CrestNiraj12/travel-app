import 'package:flutter/material.dart';
import 'package:traveller/screens/Profile/signin_screen.dart';
import 'package:traveller/screens/Profile/signup_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignIn = true;

  void toggleView() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignIn
        ? SignInScreen(toggleView: toggleView)
        : Registration(toggleView: toggleView);
  }
}
