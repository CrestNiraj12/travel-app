import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/services/destination.dart';
import 'package:traveller/states/list_query/list_loading.notifier.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';

final recommendationProvider = StateNotifierProvider.family<
    RecommendationNotifier, ListLoadingState<Destination>, Position?>(
  (ref, position) {
    return RecommendationNotifier(ref, position);
  },
);

class RecommendationNotifier extends ListLoadingNotifier<Destination> {
  RecommendationNotifier(this.ref, this.position) : super() {
    initialize();
  }

  final Ref ref;
  final Position? position;

  @override
  Future<List<Destination>>? service() =>
      ref.read(destinationServiceProvider).getRecommendations(position);
}
