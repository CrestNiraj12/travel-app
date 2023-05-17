import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/models/destination.dart';
import 'package:traveller/states/history/history.notifier.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';

final historyProvider = StateNotifierProvider.autoDispose<HistoryNotifier,
    ListLoadingState<Destination>>((ref) => HistoryNotifier(ref));
