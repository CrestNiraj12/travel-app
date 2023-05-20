import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/screens/home/nearest.dart';
import 'package:traveller/screens/home/recommendations.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/states/page_controller.provider.dart';

class HomeBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentLocationProvider).data;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(destinationListProvider('').notifier).initialize();
      },
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 50,
                ),
              ],
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 80,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                      onTap: () {
                        ref
                            .read(pageControllerProvider.notifier)
                            .state
                            .jumpToPage(Screens.search);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            size: 35,
                            color: Colors.lightBlue,
                          ),
                          _button("Places"),
                        ],
                      )),
                ),
                SizedBox(
                  width: 2.0,
                  child: Center(
                    child: Container(
                      margin: EdgeInsetsDirectional.only(start: .0, end: 1.0),
                      height: 50.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        ref
                            .read(pageControllerProvider.notifier)
                            .state
                            .jumpToPage(Screens.weather);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.wb_sunny,
                            size: 35,
                            color: Colors.lightBlue,
                          ),
                          _button("Weather")
                        ],
                      )),
                ),
              ],
            ),
          ),
          Recommendations(
            currentLocation: currentLocation,
          ),
          NearestPlaces(),
        ],
      ),
    );
  }

  Widget _button(String name) {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17,
      ),
    );
  }
}
