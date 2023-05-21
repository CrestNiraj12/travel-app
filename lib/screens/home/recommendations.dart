import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/destination/recommendation.provider.dart';
import 'package:traveller/utils/colors.dart';

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
                    "Recommendations for you",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.dark,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                  height: 250,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: SizedBox(
                            width: 300.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CachedImage(
                                    imageUrl: destination.imageUrl,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  bottom: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.dark.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              initialRating:
                                                  destination.avgReviews,
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
                                              width: 10,
                                            ),
                                            Text(
                                              '(${destination.reviews.length})',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            '${destination.name}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
