import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/services/destination.dart';
import 'package:traveller/states/list_query/list_loading.notifier.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';
import 'package:traveller/states/query/query.notifier.dart';
import 'package:traveller/states/query/query.state.dart';

final destinationListProvider = StateNotifierProvider.family<
    DestinationListNotifier, ListLoadingState<Destination>, String>(
  (ref, query) {
    return DestinationListNotifier(ref, query);
  },
);

final destinationProvider = StateNotifierProvider.family<DestinationNotifier,
    QueryState<Destination>, int>(
  (ref, id) {
    return DestinationNotifier(ref, id);
  },
);

class DestinationListNotifier extends ListLoadingNotifier<Destination> {
  DestinationListNotifier(this.ref, this.query) : super() {
    initialize();
  }

  final Ref ref;
  final String query;

  @override
  Future<List<Destination>>? service() =>
      ref.read(destinationServiceProvider).getDestinations(query);
}

class DestinationNotifier extends QueryNotifier<Destination> {
  DestinationNotifier(this.ref, this.id) : super() {
    initialize();
  }

  final Ref ref;
  final int id;

  @override
  Future<Destination>? service() =>
      ref.read(destinationServiceProvider).getDestination(id);
}
