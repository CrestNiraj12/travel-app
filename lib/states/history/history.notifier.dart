import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/services/history_service.dart';
import 'package:traveller/states/list_query/list_loading.notifier.dart';

class HistoryNotifier extends ListLoadingNotifier<Destination> {
  HistoryNotifier(this.ref) : super() {
    initialize();
  }

  final Ref ref;

  @override
  Future<List<Destination>>? service() =>
      ref.read(historyServiceProvider).getHistory();
}
