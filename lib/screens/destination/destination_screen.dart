import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/google_maps.dart';
import 'package:traveller/screens/destination/reviews.dart';
import 'package:traveller/services/history_service.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.provider.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: Text(destination.name),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref
                  .read(destinationProvider(widget.destinationId).notifier)
                  .initialize();
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 220,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: CachedImage(
                        width: double.infinity,
                        height: 280,
                        imageUrl: destination.imageUrl,
                      ),
                    ),
                  ),
                  Maps(
                    latitude: destination.latitude,
                    longitude: destination.longitude,
                    currentLocation: currentLocation,
                  ),
                  Container(
                    color: Color.fromRGBO(55, 70, 105, 1),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(4),
                      },
                      children: [
                        TableRow(children: [
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.fill,
                            child: Container(
                              width: 70,
                              color: Color.fromRGBO(95, 115, 150, 1),
                              child: Icon(
                                Icons.flag,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Ratings:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
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
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '(${destination.reviews.length} reviews)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Place :",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      destination.name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Country :",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      destination.country,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Distance :",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Description(
                    description: destination.description,
                  ),
                  Reviews(
                    destId: destination.id,
                    reviews: destination.reviews,
                  ),
                ],
              ),
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
      children: <Widget>[
        Container(
            color: Color.fromRGBO(95, 115, 150, 1),
            height: 30,
            width: double.infinity,
            child: Center(
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )),
        SizedBox(
          height: 1,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          color: Color.fromRGBO(55, 70, 105, 1),
          child: new Column(
            children: <Widget>[
              Text(
                widget.description,
                maxLines: showMore ? 500 : 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Center(
                child: InkWell(
                  child: Text(
                    showMore ? "show less" : "show more",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    ref.read(_showMoreProvider.notifier).state = !showMore;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
