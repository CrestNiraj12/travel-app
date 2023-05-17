import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/services/destination.dart';
import 'package:traveller/states/list_query/list_loading.notifier.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';

final destinationListProvider = StateNotifierProvider.family<
    DestinationNotifier, ListLoadingState<Destination>, String>(
  (ref, query) {
    return DestinationNotifier(ref, query);
  },
);

class DestinationNotifier extends ListLoadingNotifier<Destination> {
  DestinationNotifier(this.ref, this.query) : super() {
    initialize();
  }

  final Ref ref;
  final String query;

  @override
  Future<List<Destination>>? service() =>
      ref.read(destinationServiceProvider).getDestinations(query);
}
