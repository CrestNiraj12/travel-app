import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';

final destinationServiceProvider =
    Provider<DestinationService>((ref) => DestinationService(ref));

abstract class IDestinationService {
  Future<List<Destination>> getDestinations();
}

class DestinationService extends IDestinationService {
  DestinationService(this.ref);
  final Ref ref;

  @override
  Future<List<Destination>> getDestinations() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('destinations').get();
    final response = snapshot.docs;
    final List<Destination> destinations = [];
    for (final r in response) {
      final data = r.data();
      data['id'] = r.id;
      destinations.add(Destination.fromJson(data));
    }
    return destinations;
  }
}
