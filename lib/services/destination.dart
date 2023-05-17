import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/main.dart';
import 'package:traveller/models/destination.dart';

final destinationServiceProvider =
    Provider<DestinationService>((ref) => DestinationService(ref));

abstract class IDestinationService {
  Future<List<Destination>> getDestinations(String query);
  Future<List<Destination>> searchDestinations(String query);
}

class DestinationService extends IDestinationService {
  DestinationService(this.ref);
  final Ref ref;

  @override
  Future<List<Destination>> getDestinations(String query) async {
    final response = await ref.read(httpClientProvider).get(
      "/destinations",
      queryParameters: {
        'q': query,
      },
    );
    final data = response.data;
    final List<Destination> destinations = [];

    for (final dest in data) {
      destinations.add(Destination.fromJson(dest));
    }
    return destinations;
  }

  @override
  Future<List<Destination>> searchDestinations(String query) async {
    final response = await ref.read(httpClientProvider).get(
      "/destinations",
      queryParameters: {
        'q': query,
      },
    );
    final data = response.data;
    final List<Destination> destinations = [];

    for (final dest in data) {
      destinations.add(Destination.fromJson(dest));
    }
    return destinations;
  }
}
