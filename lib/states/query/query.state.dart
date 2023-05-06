import 'package:freezed_annotation/freezed_annotation.dart';

part 'query.state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class QueryState<T> with _$QueryState<T> {
  const QueryState._();

  const factory QueryState.loading() = _StateLoading<T>;
  const factory QueryState.initializing({T? initial}) = _StateInitializing<T>;
  const factory QueryState.data(T data) = _StateData<T>;
  const factory QueryState.error({Object? error, StackTrace? trace}) =
      _StateError<T>;

  T? get data => when(
        loading: () => null,
        initializing: (initial) => initial,
        data: (data) => data,
        error: (_, __) => null,
      );

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);
}
