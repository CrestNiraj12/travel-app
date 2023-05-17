import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_loading.state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ListLoadingState<T> with _$ListLoadingState<T> {
  const ListLoadingState._();

  factory ListLoadingState({
    @Default([]) List<T> data,
    @Default('') String error,
    @Default(false) bool isLoading,
  }) = _ListLoadingState;

  List<T> get allData {
    return data;
  }

  List<Widget> mapStates({
    required Widget loading,
    required Widget data,
    Widget? error,
    Widget? empty,
    VoidCallback? onRetry,
  }) {
    return [
      if (isLoading)
        loading
      else if (this.error.isNotEmpty)
        error ?? Text('Error occured', style: TextStyle(color: Colors.red))
      else if (allData.isEmpty)
        empty ?? SizedBox.shrink()
      else if (allData.isNotEmpty)
        data,
    ];
  }

  Widget mapStatesToWidget({
    required Widget loading,
    required Widget data,
    Widget? error,
    Widget? empty,
    VoidCallback? onRetry,
  }) {
    if (isLoading) {
      return loading;
    }
    if (this.error.isNotEmpty) {
      return error ??
          Text('Error occurred', style: TextStyle(color: Colors.red));
    }
    if (allData.isEmpty) {
      return empty ?? SizedBox.shrink();
    }

    if (allData.isNotEmpty) {
      return data;
    }
    return loading;
  }
}
