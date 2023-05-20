import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';

class NearestPlaces extends ConsumerWidget {
  const NearestPlaces({
    Key? key,
  });

  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = ref.watch(destinationListProvider(''));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5, left: 8),
          child: Text(
            "Nearest Places",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        destinations.mapStatesToWidget(
          loading: SizedBox.shrink(),
          data: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 50)]),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: min(destinations.allData.length, 10),
              itemBuilder: (BuildContext context, int i) {
                final destination = destinations.allData[i];
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
        ),
      ],
    );
  }
}
