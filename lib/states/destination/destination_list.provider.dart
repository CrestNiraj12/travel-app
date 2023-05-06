import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/services/destination.dart';
import 'package:traveller/states/list_query/list_loading.notifier.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';

final destinationNotifierProvider =
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
