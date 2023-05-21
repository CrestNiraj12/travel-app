import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/models/review.dart';
import 'package:traveller/screens/destination/review_form.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.provider.dart';

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
    final isAuthenticated =
        ref.watch(authRedirectionProvider.notifier).isAuthenticated;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${reviews.length} reviews',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (isAuthenticated)
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
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          if (!isAuthenticated)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  'You need to login first to submit review 😊',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              if (reviews.isEmpty)
                Text(
                  'Be the first one to review 😍',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ...reviews.map((review) {
                final avatar = review.user.avatar;
                final df = DateFormat('yyyy-MM-dd HH:mm a');

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedImage(
                        imageUrl: review.user.avatar,
                        height: 35,
                        width: 35,
                        radius: 100,
                        addUrlPrefix: !avatar.contains("http"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  df.format(review.updatedAt.toLocal()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
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
                            SizedBox(
                              height: 7,
                            ),
                            if (review.comment != null)
                              Text(
                                review.comment ?? '',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
