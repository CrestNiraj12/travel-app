import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/utils/colors.dart';
import 'package:traveller/utils/distance.dart';

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
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.dark,
            ),
          ),
        ),
        destinations.mapStatesToWidget(
          loading: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
          data: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
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
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CachedImage(
                              imageUrl: destination.imageUrl,
                              width: double.infinity,
                              radius: 15,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${destination.name}',
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  getDistance(
                                    ref,
                                    latitude: destination.latitude,
                                    longitude: destination.longitude,
                                  ),
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: destination.avgReviews,
                                      minRating: 0,
                                      maxRating: 5,
                                      direction: Axis.horizontal,
                                      itemSize: 20,
                                      allowHalfRating: true,
                                      unratedColor: Colors.grey,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(
                                        horizontal: 0.0,
                                      ),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '(${destination.reviews.length})',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
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
