import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/screens/Profile/profile.dart';
import 'package:traveller/states/bottom_nav.provider.dart';

import 'screens/home/home.dart';
import 'screens/weather/weather-main.dart';

class Traveller extends ConsumerWidget {
  final position = [
    // Places(),
    // Search(),
    Home(),
    Weather(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(bottomNavProvider);

    Widget _getNavButton(String text, IconData icon, int index) {
      return InkWell(
        onTap: () {
          ref.read(bottomNavProvider.notifier).state = index;
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

    return Scaffold(
      body: position[page],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            ref.read(bottomNavProvider.notifier).state = 0;
          },
          child: new Icon(Icons.home),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
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
              _getNavButton('Profile', Icons.person, 2),
            ],
          ),
        ),
      ),
    );
  }
}
