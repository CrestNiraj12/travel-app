import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traveller/components/loader.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    final user = FirebaseAuth.instance.currentUser;
    final imageURL = user?.photoURL ??
        "https://ui-avatars.com/api/?name=${user?.displayName ?? user?.email}&size=120";

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 260.0,
            width: double.infinity,
            color: Colors.lightBlue,
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 15.0),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.red,
                      backgroundImage:
                          user != null ? NetworkImage(imageURL) : null,
                      child:
                          user == null ? Text(user?.displayName ?? '') : null,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          user?.displayName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user?.email ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 13.0,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_loading) return;
                    setState(() {
                      _loading = true;
                    });
                    FirebaseAuth.instance.signOut();
                    globalScaffoldKey.currentState?.showSnackBar(
                      showSnackBar(content: 'Successfully logged out'),
                    );
                    if (mounted) {
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _loading
                        ? Loader()
                        : Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
