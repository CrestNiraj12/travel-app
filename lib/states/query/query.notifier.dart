import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/states/query/query.state.dart';

abstract class QueryNotifier<T> extends StateNotifier<QueryState<T>> {
  QueryNotifier() : super(const QueryState.initializing());

  @protected
  Future<T>? service();

  Future<void> initialize() async {
    if (state.isLoading) {
      return;
    }

    state = const QueryState.loading();

    try {
      final response = await service();
      if (response != null) {
        state = QueryState.data(response);
      }
    } catch (e) {
      state = QueryState.error(error: e);
    }
  }

  @override
  set state(QueryState<T> s) {
    if (mounted) {
      super.state = s;
    }
  }

  Future<void> refetch({bool isLoading = true}) async {
    try {
      if (state.isLoading) {
        return;
      }
      if (isLoading) {
        state = const QueryState.loading();
      }
      final response = await service()!;
      state = QueryState.data(response);
    } catch (e) {
      state = QueryState.error(error: e);
    }
  }
}
