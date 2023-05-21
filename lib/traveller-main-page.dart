import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/screens/Profile/profile.dart';
import 'package:traveller/screens/search/search.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.provider.dart';
import 'package:traveller/states/page_controller.provider.dart';
import 'package:traveller/utils/colors.dart';

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
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: ref.read(pageControllerProvider.notifier).state,
        onPageChanged: onPageChanged,
        children: pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.blue.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 3,
            ),
          ],
        ),
        child: BottomAppBar(
          height: 60,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _getNavButton('Home', Icons.home, Screens.home),
                _getNavButton('Search', Icons.search, Screens.search),
                _getNavButton('Weather', Icons.wb_sunny, Screens.weather),
                _getNavButton('Profile', Icons.person, Screens.profile),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
