import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/utils/distance.dart';

class Search extends ConsumerStatefulWidget {
  const Search({Key? key});

  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _controller = TextEditingController();

  String getDistance(GeoPoint destination) {
    final pos = ref.read(currentLocationProvider).data;

    if (pos == null) return 'distance unavailable';

    return calculateDistance(
          pos.latitude,
          pos.longitude,
          destination.latitude,
          destination.longitude,
        ).toStringAsFixed(2) +
        ' km away';
  }

  @override
  Scaffold build(BuildContext context) {
    super.build(context);
    ref.watch(currentLocationProvider);
    final destinations = ref.watch(destinationNotifierProvider);

    void _handleSearch() async {
      // setState(() {
      //   destinationsDoc = collection
      //       .where('name', isGreaterThanOrEqualTo: _controller.text)
      //       .where('name', isLessThan: _controller.text + 'z')
      //       .get();
      // });
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(destinationNotifierProvider.notifier).initialize();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SearchForm(
                controller: _controller,
                handleSearch: _handleSearch,
              ),
              destinations.mapStatesToWidget(
                loading: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircularProgressIndicator(),
                  ),
                ),
                data: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for (final destination in destinations.allData)
                        GestureDetector(
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
                                        CachedImage(
                                          imageUrl: destination.imageUrl,
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
                                                getDistance(
                                                    destination.location),
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
                        ),
                    ]),
              ),
            ],
          ),
        ),
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
    required this.handleSearch,
  });

  final TextEditingController controller;
  final Function() handleSearch;

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
                onPressed: handleSearch,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
