import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:traveller/states/query/query.notifier.dart';
import 'package:traveller/states/query/query.state.dart';

final currentLocationProvider =
    StateNotifierProvider<CurrentLocationNotifier, QueryState<Position>>((ref) {
  return CurrentLocationNotifier(ref);
});

class CurrentLocationNotifier extends QueryNotifier<Position> {
  CurrentLocationNotifier(this.ref) : super() {
    initialize();
  }

  final Ref ref;

  @override
  Future<Position>? service() async {
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return pos;
  }
}
