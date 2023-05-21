import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/screens/home/nearest.dart';
import 'package:traveller/screens/home/recommendations.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/states/destination/recommendation.provider.dart';

class HomeBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentLocationProvider).data;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(destinationListProvider('').notifier).initialize();
        ref.read(recommendationProvider(currentLocation).notifier).initialize();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Recommendations(
              currentLocation: currentLocation,
            ),
            NearestPlaces(),
          ],
        ),
      ),
    );
  }
}
