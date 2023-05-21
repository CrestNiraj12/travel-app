import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/destination/recommendation.provider.dart';

class Recommendations extends ConsumerWidget {
  const Recommendations({
    Key? key,
    required this.currentLocation,
  });

  final Position? currentLocation;

  Widget build(BuildContext context, WidgetRef ref) {
    final recommendations = ref.watch(recommendationProvider(currentLocation));

    return recommendations.mapStatesToWidget(
      loading: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ),
      data: recommendations.allData.length <= 0
          ? SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 8),
                  child: Text(
                    "Recommendations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 50)
                  ]),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                  height: 270,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: min(recommendations.allData.length, 10),
                    itemBuilder: (BuildContext context, int i) {
                      final destination = recommendations.allData[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DestinationScreen(
                                destinationId: destination.id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 340.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CachedImage(
                                    imageUrl: destination.imageUrl,
                                    width: double.infinity,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
