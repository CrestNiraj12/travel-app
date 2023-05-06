import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/states/list_query/list_loading.state.dart';

abstract class ListLoadingNotifier<T>
    extends StateNotifier<ListLoadingState<T>> {
  ListLoadingNotifier() : super(ListLoadingState());

  @protected
  Future<List<T>>? service();

  Future<void> initialize() async {
    if (state.isLoading || !mounted) {
      return;
    }
    state = state.copyWith(
      isLoading: true,
      error: '',
      data: [],
    );

    try {
      final response = await service();
      if (response != null && mounted) {
        state = state.copyWith(
          isLoading: true,
          error: '',
          data: response,
        );
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(
          error: e.toString(),
        );
      }
    } finally {
      if (mounted) {
        state = state.copyWith(
          isLoading: false,
        );
      }
    }
  }

  Future<void> refetchAll({bool isRetry = false}) async {
    if (!mounted) {
      return;
    }
    if (state.data.isEmpty) {
      await initialize();
      return;
    }
    state = state.copyWith(
      error: '',
      isLoading: isRetry,
    );
    ListLoadingState<T> newState = state.copyWith();
    try {
      state = newState.copyWith(
        isLoading: false,
        data: await service()!,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}
