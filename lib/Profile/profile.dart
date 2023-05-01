import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traveller/profile/authenticate.dart';
import 'package:traveller/profile/profile_home.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: auth.currentUser != null ? ProfileHome() : Authenticate(),
    );
  }
}
