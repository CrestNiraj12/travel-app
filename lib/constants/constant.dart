import 'package:flutter/material.dart';

final Color? iconColor = Colors.grey[500];

InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.grey[300],
  filled: true,
);

final globalScaffoldKey = GlobalKey<ScaffoldMessengerState>();

class Screens {
  Screens._();
  static const home = 0;
  static const search = 1;
  static const weather = 2;
  static const profile = 3;
}
