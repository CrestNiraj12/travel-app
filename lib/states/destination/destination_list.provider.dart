import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/screens/search/search.dart';
import 'package:traveller/services/destination.dart';
import 'package:traveller/states/list_query/list_loading.notifier.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';

final destinationListProvider =
    StateNotifierProvider<DestinationNotifier, ListLoadingState<Destination>>(
        (ref) {
  return DestinationNotifier(ref);
});

class DestinationNotifier extends ListLoadingNotifier<Destination> {
  DestinationNotifier(this.ref) : super() {
    initialize();
  }

  final Ref ref;

  @override
  Future<List<Destination>>? service() =>
      ref.read(destinationServiceProvider).getDestinations();
}

final searchedDestinationListProvider = StateNotifierProvider.autoDispose<
    SearchedDestinationNotifier, ListLoadingState<Destination>>((ref) {
  return SearchedDestinationNotifier(ref);
});

class SearchedDestinationNotifier extends ListLoadingNotifier<Destination> {
  SearchedDestinationNotifier(this.ref) : super() {
    initialize();
  }

  final Ref ref;

  @override
  Future<List<Destination>>? service() {
    final query = searchController.text;
    return ref.read(destinationServiceProvider).searchDestinations(query);
  }
}
