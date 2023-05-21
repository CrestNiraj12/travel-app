import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveller/components/image.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/screens/destination/destination_screen.dart';
import 'package:traveller/states/current_location/current_location.provider.dart';
import 'package:traveller/states/destination/destination_list.provider.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';
import 'package:traveller/utils/colors.dart';
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _handleSearch() async {
    ref.read(isSearchedProvider.notifier).state = true;
    ref.read(searchQueryProvider.notifier).state = searchController.text.trim();
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
      data: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 15.0,
          top: 15.0,
          bottom: 100.0,
        ),
        child: Wrap(
          children: [
            for (final Destination destination in destinations.allData)
              Container(
                constraints: BoxConstraints(
                  maxWidth: 185,
                ),
                padding: EdgeInsets.only(
                  right: 5,
                  top: 5,
                ),
                child: GestureDetector(
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SizedBox(
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CachedImage(
                            imageUrl: destination.imageUrl,
                            height: 125,
                            isBottomRadius: false,
                            radius: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 5),
                                Text(
                                  destination.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.dark,
                                  ),
                                ),
                                SizedBox(height: 10),
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
                                        color: AppColors.green,
                                      ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: 66,
                                  child: Text(
                                    destination.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          height: 1.3,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[700],
                                        ),
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
              ),
          ],
        ),
      ),
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
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Discover the world's ",
            style: GoogleFonts.lato(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          Text(
            "hidden gems...",
            style: GoogleFonts.lato(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: AppColors.dark,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => handleSearch(),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.primary,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.blue,
              ),
              suffixIcon: isSearched
                  ? IconButton(
                      icon: Icon(Icons.close),
                      onPressed: handleCancelSearch,
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
