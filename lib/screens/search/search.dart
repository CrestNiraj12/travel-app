import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';
import 'package:traveller/utils/distance.dart';

class Search extends ConsumerStatefulWidget {
  const Search({Key? key});

  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search>
    with AutomaticKeepAliveClientMixin {
  final searchController = TextEditingController();
  final isSearchedProvider = StateProvider<bool>((ref) => false);
  final searchQueryProvider = StateProvider<String>((ref) => '');

  void _handleSearch() async {
    ref.read(isSearchedProvider.notifier).state = true;
    ref.read(searchQueryProvider.notifier).state = searchController.text;
  }

  void _handleCancelSearch() async {
    ref.read(isSearchedProvider.notifier).state = false;
    searchController.clear();
    ref.read(searchQueryProvider.notifier).state = '';
  }

  @override
  Scaffold build(BuildContext context) {
    super.build(context);
    ref.watch(currentLocationProvider);
    final query = ref.watch(searchQueryProvider);
    final isSearched = ref.watch(isSearchedProvider);
    final destinations = ref.watch(destinationListProvider(query));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(searchQueryProvider.notifier).state = '';
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SearchForm(
                controller: searchController,
                handleSearch: _handleSearch,
                isSearched: isSearched,
                handleCancelSearch: _handleCancelSearch,
              ),
              DestinationItem(destinations: destinations),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DestinationItem extends ConsumerWidget {
  const DestinationItem({
    required this.destinations,
  });

  final ListLoadingState destinations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return destinations.mapStatesToWidget(
      loading: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: CircularProgressIndicator(),
        ),
      ),
      error: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Something went wrong!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
      empty: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: Colors.redAccent,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'No search results found!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
      data: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (final Destination destination in destinations.allData)
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CachedImage(
                                imageUrl: destination.imageUrl,
                              ),
                              Container(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(height: 5),
                                    Text(
                                      destination.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Container(height: 5),
                                    Text(
                                      getDistance(
                                        ref,
                                        latitude: destination.latitude,
                                        longitude: destination.longitude,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey[700],
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
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key? key,
    required this.controller,
    required this.handleSearch,
    required this.isSearched,
    required this.handleCancelSearch,
  });

  final TextEditingController controller;
  final Function() handleSearch;
  final bool isSearched;
  final Function() handleCancelSearch;

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
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => handleSearch(),
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              suffixIcon: Wrap(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: handleSearch,
                  ),
                  if (isSearched)
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: handleCancelSearch,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
