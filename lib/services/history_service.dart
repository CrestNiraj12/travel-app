import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/main.dart';
import 'package:traveller/models/destination.dart';

final historyServiceProvider =
    Provider<HistoryService>((ref) => HistoryService(ref));

abstract class IHistoryService {
  Future<List<Destination>> getHistory();
  void addToHistory(int dest_id);
}

class HistoryService extends IHistoryService {
  HistoryService(this.ref);
  final Ref ref;

  @override
  Future<List<Destination>> getHistory() async {
    final response = await ref.read(httpClientProvider).get("/user/history");
    final history = response.data;
    final List<Destination> destinations = [];

    for (final dest in history) {
      destinations.add(Destination.fromJson(dest['destination']));
    }
    return destinations;
  }

  @override
  void addToHistory(int destinationId) async {
    await ref.read(httpClientProvider).post(
      "/user/history",
      data: {
        'dest_id': destinationId,
      },
    );
  }
}
