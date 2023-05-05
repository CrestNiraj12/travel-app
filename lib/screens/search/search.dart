import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/utils/current_location.dart';

class Search extends StatefulWidget {
  const Search({Key? key});

  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    CollectionReference destinationsDoc =
        FirebaseFirestore.instance.collection('destinations');

    double calculateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var a = 0.5 -
          cos((lat2 - lat1) * p) / 2 +
          cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    Future<String> getDistance(GeoPoint destination) async {
      final pos = await getCurrentLocation();

      return calculateDistance(
        pos.latitude,
        pos.longitude,
        destination.latitude,
        destination.longitude,
      ).toStringAsFixed(2);
    }

    return Scaffold(
      body: Column(
        children: [
          SearchForm(controller: _controller),
          FutureBuilder<QuerySnapshot>(
            future: destinationsDoc.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircularProgressIndicator(),
                  ),
                );
              if (snapshot.hasError || !snapshot.hasData)
                return SizedBox.shrink();

              final destinations = snapshot.data?.docs ?? [];
              if (destinations.isEmpty) return SizedBox.shrink();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: destinations.length,
                itemBuilder: (context, i) {
                  final data = destinations[i].data() as Map<String, dynamic>;
                  data['id'] = destinations[i].id;
                  final destination = Destination.fromJson(data);
                  return FutureBuilder<String>(
                    future: getDistance(destination.location),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      final distance = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DestinationScreen(destination: destination),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Image.network(
                                        destination.imageUrl,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(height: 5),
                                            Text(
                                              destination.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                            Container(height: 5),
                                            Text(
                                              "$distance km away",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.grey[500],
                                                  ),
                                            ),
                                            Container(height: 10),
                                            Text(
                                              destination.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: Colors.grey[700],
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key? key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 60,
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
