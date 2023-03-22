import 'package:flutter/material.dart';

import 'Home/home.dart';
import 'Weather/weather-main.dart';

class Traveller extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TravellerState();
  }
}

class TravellerState extends State<Traveller> {
  int _page = 0;
  final position = [
    // Places(),
    // Search(),
    Home(),
    Weather(),
    // Profile(),
  ];

  Widget _getNavButton(String text, IconData icon, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _page = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: position[_page],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            setState(() {
              _page = 0;
            });
          },
          child: new Icon(Icons.home),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.blueAccent,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 20,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _getNavButton('Search', Icons.search, 0),
              _getNavButton('Weather', Icons.wb_sunny, 1),
              _getNavButton('Profile', Icons.person, 0),
            ],
          ),
        ),
      ),
    );
  }
}
