import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/screens/Profile/profile.dart';
import 'package:traveller/screens/search/search.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.provider.dart';
import 'package:traveller/states/page_controller.provider.dart';

import 'screens/home/home.dart';
import 'screens/weather/weather-main.dart';

class Traveller extends ConsumerStatefulWidget {
  const Traveller({
    Key? key,
    this.screen = Screens.home,
  });

  final int screen;

  @override
  ConsumerState<Traveller> createState() => _TravellerState();
}

class _TravellerState extends ConsumerState<Traveller> {
  void onPageChanged(int index) {
    ref.read(pageControllerProvider.notifier).state.jumpToPage(index);
  }

  final pages = [
    Home(),
    Search(),
    Weather(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();

    _requestLocationPermission();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.screen != Screens.home)
        ref
            .read(pageControllerProvider.notifier)
            .state
            .jumpToPage(widget.screen);
    });
  }

  void _requestLocationPermission() async {
    await Permission.locationWhenInUse.request();

    switch (await Permission.locationWhenInUse.serviceStatus) {
      case ServiceStatus.enabled:
        break;
      case ServiceStatus.disabled:
      case ServiceStatus.notApplicable:
        print('location permission denied');
        _showLocationDeniedDialog();
        throw Error();
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Location is disabled :(',
              style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FilledButton(
              child: Text(
                'Enable!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authRedirectionProvider, (_, __) {});

    Widget _getNavButton(String text, IconData icon, int index) {
      return InkWell(
        onTap: () {
          ref.read(pageControllerProvider.notifier).state.jumpToPage(index);
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
      body: PageView(
        controller: ref.read(pageControllerProvider.notifier).state,
        onPageChanged: onPageChanged,
        children: pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            ref
                .read(pageControllerProvider.notifier)
                .state
                .jumpToPage(Screens.home);
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
              _getNavButton('Search', Icons.search, Screens.search),
              _getNavButton('Weather', Icons.wb_sunny, Screens.weather),
              _getNavButton('Profile', Icons.person, Screens.profile),
            ],
          ),
        ),
      ),
    );
  }
}
