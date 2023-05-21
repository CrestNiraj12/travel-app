import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/google_maps.dart';
import 'package:traveller/screens/destination/reviews.dart';
import 'package:traveller/services/history_service.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.provider.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/utils/colors.dart';
import 'package:traveller/utils/distance.dart';

class DestinationScreen extends ConsumerStatefulWidget {
  const DestinationScreen({
    required this.destinationId,
  });

  final int destinationId;

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends ConsumerState<DestinationScreen> {
  final visibilityProvider = StateProvider((ref) => true);

  @override
  void initState() {
    super.initState();
    _addToHistory();
  }

  void _addToHistory() async {
    if (ref.read(authRedirectionProvider.notifier).isAuthenticated) {
      ref.read(historyServiceProvider).addToHistory(widget.destinationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = ref.watch(currentLocationProvider).data;
    final destination = ref.watch(destinationProvider(widget.destinationId));
    final isVisible = ref.watch(visibilityProvider);

    return destination.when(
      loading: () => Scaffold(
        appBar: AppBar(
          title: Text('Destination'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      data: (destination) {
        return WillPopScope(
          onWillPop: () async {
            ref.read(visibilityProvider.notifier).state = false;
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  child: CachedImage(
                    width: double.infinity,
                    height: 400,
                    radius: 0,
                    imageUrl: destination.imageUrl,
                    color: Colors.black45,
                    colorBlendMode: BlendMode.colorBurn,
                  ),
                ),
                NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 330.0,
                        pinned: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: Stack(
                          children: [
                            Positioned(
                              bottom: 30,
                              left: 30,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: destination.avgReviews,
                                        minRating: 0,
                                        maxRating: 5,
                                        direction: Axis.horizontal,
                                        itemSize: 25,
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
                                      Text(
                                        '(${destination.reviews.length} reviews)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppColors.primary,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        1.25,
                                    child: Text(
                                      destination.name,
                                      style: GoogleFonts.lato(
                                        fontSize: 38,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: RefreshIndicator(
                    onRefresh: () async {
                      ref
                          .read(destinationProvider(widget.destinationId)
                              .notifier)
                          .initialize();
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 30,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Distance :",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    getDistance(
                                      ref,
                                      latitude: destination.latitude,
                                      longitude: destination.longitude,
                                    ),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Description(
                                description: destination.description,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: isVisible,
                                child: Maps(
                                  latitude: destination.latitude,
                                  longitude: destination.longitude,
                                  currentLocation: currentLocation,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Reviews(
                                destId: destination.id,
                                reviews: destination.reviews,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (_, __) => Text("Error"),
      initializing: (_) => SizedBox.shrink(),
    );
  }
}

class Description extends ConsumerStatefulWidget {
  const Description({
    Key? key,
    required this.description,
  });

  final String description;

  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends ConsumerState<Description> {
  final _showMoreProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context) {
    final showMore = ref.watch(_showMoreProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Description",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.description,
              maxLines: showMore ? 500 : 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            InkWell(
              child: Text(
                showMore ? "show less" : "show more",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                ref.read(_showMoreProvider.notifier).state = !showMore;
              },
            ),
          ],
        ),
      ],
    );
  }
}
