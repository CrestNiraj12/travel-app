import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traveller/screens/profile/authenticate.dart';
import 'package:traveller/screens/profile/profile_home.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            (snapshot.data != null) ? ProfileHome() : Authenticate(),
      ),
    );
  }
}
