import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/services/review_service.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';

class ReviewForm extends ConsumerStatefulWidget {
  const ReviewForm({
    Key? key,
    required this.destId,
  });

  final int destId;

  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends ConsumerState<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _ratingProvider = StateProvider<double>((ref) => 0);
  final _loadingProvider = StateProvider<bool>((ref) => false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit(double ratings) async {
    if (ratings <= 0) {
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: 'You need to provide ratings before submitting',
          type: SnackbarType.info,
        ),
      );
      return;
    }
    ;

    ref.read(_loadingProvider.notifier).state = true;

    final data = {
      'ratings': ratings,
      'comment': _controller.text.trim(),
      'dest_id': widget.destId,
    };
    try {
      await ref.read(reviewServiceProvider).submitReview(data);
      ref.read(destinationProvider(widget.destId).notifier).initialize();
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: 'Review has been submitted successfully 🥰',
          type: SnackbarType.success,
        ),
      );
    } catch (e) {
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: 'Failed while submitting review 🥲',
          type: SnackbarType.error,
        ),
      );
    } finally {
      if (mounted) {
        ref.read(_loadingProvider.notifier).state = false;
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratings = ref.watch(_ratingProvider);
    final isLoading = ref.watch(_loadingProvider);
    final isAuthenticated =
        ref.watch(authRedirectionProvider.notifier).isAuthenticated;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        height: 450,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 50.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Provide your ratings: ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RatingBar.builder(
                        initialRating: 0,
                        minRating: 0,
                        maxRating: 5,
                        direction: Axis.horizontal,
                        itemSize: 40,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(
                          horizontal: 0.0,
                        ),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          ref.read(_ratingProvider.notifier).state = rating;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Write your review (Optional): ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _controller,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.3,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                      ),
                      maxLines: 6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isAuthenticated
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isLoading
                                      ? Colors.grey
                                      : Colors.blueAccent,
                                ),
                                onPressed: isLoading
                                    ? null
                                    : () => _handleSubmit(ratings),
                                child: isLoading
                                    ? SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 7,
                                            horizontal: 7,
                                          ),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      )
                                    : Text('Submit'),
                              )
                            : Text(
                                'You need to login first to submit review 🤩',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
