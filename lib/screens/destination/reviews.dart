import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/review.dart';
import 'package:traveller/screens/destination/review_form.dart';

class Reviews extends ConsumerWidget {
  const Reviews({
    Key? key,
    required this.reviews,
    required this.destId,
  });

  final List<Review> reviews;
  final int destId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Reviews',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ReviewForm(
                  destId: destId,
                ),
              );
            },
            child: Text(
              'Write a review',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              if (reviews.isEmpty)
                Center(
                  child: Text(
                    'Be the first one to review 😍',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ...reviews
                  .map((review) => Column(
                        children: [
                          Wrap(
                            children: [
                              Text(
                                review.user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                review.updatedAt.toLocal().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: review.ratings,
                            minRating: 0,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            itemSize: 15,
                            allowHalfRating: true,
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
                          if (review.comment != null)
                            Text(
                              review.comment ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
