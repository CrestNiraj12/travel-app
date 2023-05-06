// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QueryState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T? initial) initializing,
    required TResult Function(T data) data,
    required TResult Function(Object? error, StackTrace? trace) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T? initial)? initializing,
    TResult? Function(T data)? data,
    TResult? Function(Object? error, StackTrace? trace)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T? initial)? initializing,
    TResult Function(T data)? data,
    TResult Function(Object? error, StackTrace? trace)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateLoading<T> value) loading,
    required TResult Function(_StateInitializing<T> value) initializing,
    required TResult Function(_StateData<T> value) data,
    required TResult Function(_StateError<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateLoading<T> value)? loading,
    TResult? Function(_StateInitializing<T> value)? initializing,
    TResult? Function(_StateData<T> value)? data,
    TResult? Function(_StateError<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateLoading<T> value)? loading,
    TResult Function(_StateInitializing<T> value)? initializing,
    TResult Function(_StateData<T> value)? data,
    TResult Function(_StateError<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryStateCopyWith<T, $Res> {
  factory $QueryStateCopyWith(
          QueryState<T> value, $Res Function(QueryState<T>) then) =
      _$QueryStateCopyWithImpl<T, $Res, QueryState<T>>;
}

/// @nodoc
class _$QueryStateCopyWithImpl<T, $Res, $Val extends QueryState<T>>
    implements $QueryStateCopyWith<T, $Res> {
  _$QueryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_StateLoadingCopyWith<T, $Res> {
  factory _$$_StateLoadingCopyWith(
          _$_StateLoading<T> value, $Res Function(_$_StateLoading<T>) then) =
      __$$_StateLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$_StateLoadingCopyWithImpl<T, $Res>
    extends _$QueryStateCopyWithImpl<T, $Res, _$_StateLoading<T>>
    implements _$$_StateLoadingCopyWith<T, $Res> {
  __$$_StateLoadingCopyWithImpl(
      _$_StateLoading<T> _value, $Res Function(_$_StateLoading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_StateLoading<T> extends _StateLoading<T> {
  const _$_StateLoading() : super._();

  @override
  String toString() {
    return 'QueryState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_StateLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T? initial) initializing,
    required TResult Function(T data) data,
    required TResult Function(Object? error, StackTrace? trace) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T? initial)? initializing,
    TResult? Function(T data)? data,
    TResult? Function(Object? error, StackTrace? trace)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T? initial)? initializing,
    TResult Function(T data)? data,
    TResult Function(Object? error, StackTrace? trace)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateLoading<T> value) loading,
    required TResult Function(_StateInitializing<T> value) initializing,
    required TResult Function(_StateData<T> value) data,
    required TResult Function(_StateError<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateLoading<T> value)? loading,
    TResult? Function(_StateInitializing<T> value)? initializing,
    TResult? Function(_StateData<T> value)? data,
    TResult? Function(_StateError<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateLoading<T> value)? loading,
    TResult Function(_StateInitializing<T> value)? initializing,
    TResult Function(_StateData<T> value)? data,
    TResult Function(_StateError<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _StateLoading<T> extends QueryState<T> {
  const factory _StateLoading() = _$_StateLoading<T>;
  const _StateLoading._() : super._();
}

/// @nodoc
abstract class _$$_StateInitializingCopyWith<T, $Res> {
  factory _$$_StateInitializingCopyWith(_$_StateInitializing<T> value,
          $Res Function(_$_StateInitializing<T>) then) =
      __$$_StateInitializingCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? initial});
}

/// @nodoc
class __$$_StateInitializingCopyWithImpl<T, $Res>
    extends _$QueryStateCopyWithImpl<T, $Res, _$_StateInitializing<T>>
    implements _$$_StateInitializingCopyWith<T, $Res> {
  __$$_StateInitializingCopyWithImpl(_$_StateInitializing<T> _value,
      $Res Function(_$_StateInitializing<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initial = freezed,
  }) {
    return _then(_$_StateInitializing<T>(
      initial: freezed == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$_StateInitializing<T> extends _StateInitializing<T> {
  const _$_StateInitializing({this.initial}) : super._();

  @override
  final T? initial;

  @override
  String toString() {
    return 'QueryState<$T>.initializing(initial: $initial)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StateInitializing<T> &&
            const DeepCollectionEquality().equals(other.initial, initial));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(initial));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StateInitializingCopyWith<T, _$_StateInitializing<T>> get copyWith =>
      __$$_StateInitializingCopyWithImpl<T, _$_StateInitializing<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T? initial) initializing,
    required TResult Function(T data) data,
    required TResult Function(Object? error, StackTrace? trace) error,
  }) {
    return initializing(initial);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T? initial)? initializing,
    TResult? Function(T data)? data,
    TResult? Function(Object? error, StackTrace? trace)? error,
  }) {
    return initializing?.call(initial);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T? initial)? initializing,
    TResult Function(T data)? data,
    TResult Function(Object? error, StackTrace? trace)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(initial);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateLoading<T> value) loading,
    required TResult Function(_StateInitializing<T> value) initializing,
    required TResult Function(_StateData<T> value) data,
    required TResult Function(_StateError<T> value) error,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateLoading<T> value)? loading,
    TResult? Function(_StateInitializing<T> value)? initializing,
    TResult? Function(_StateData<T> value)? data,
    TResult? Function(_StateError<T> value)? error,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateLoading<T> value)? loading,
    TResult Function(_StateInitializing<T> value)? initializing,
    TResult Function(_StateData<T> value)? data,
    TResult Function(_StateError<T> value)? error,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class _StateInitializing<T> extends QueryState<T> {
  const factory _StateInitializing({final T? initial}) =
      _$_StateInitializing<T>;
  const _StateInitializing._() : super._();

  T? get initial;
  @JsonKey(ignore: true)
  _$$_StateInitializingCopyWith<T, _$_StateInitializing<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_StateDataCopyWith<T, $Res> {
  factory _$$_StateDataCopyWith(
          _$_StateData<T> value, $Res Function(_$_StateData<T>) then) =
      __$$_StateDataCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$_StateDataCopyWithImpl<T, $Res>
    extends _$QueryStateCopyWithImpl<T, $Res, _$_StateData<T>>
    implements _$$_StateDataCopyWith<T, $Res> {
  __$$_StateDataCopyWithImpl(
      _$_StateData<T> _value, $Res Function(_$_StateData<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_StateData<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_StateData<T> extends _StateData<T> {
  const _$_StateData(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'QueryState<$T>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StateData<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StateDataCopyWith<T, _$_StateData<T>> get copyWith =>
      __$$_StateDataCopyWithImpl<T, _$_StateData<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T? initial) initializing,
    required TResult Function(T data) data,
    required TResult Function(Object? error, StackTrace? trace) error,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T? initial)? initializing,
    TResult? Function(T data)? data,
    TResult? Function(Object? error, StackTrace? trace)? error,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T? initial)? initializing,
    TResult Function(T data)? data,
    TResult Function(Object? error, StackTrace? trace)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateLoading<T> value) loading,
    required TResult Function(_StateInitializing<T> value) initializing,
    required TResult Function(_StateData<T> value) data,
    required TResult Function(_StateError<T> value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateLoading<T> value)? loading,
    TResult? Function(_StateInitializing<T> value)? initializing,
    TResult? Function(_StateData<T> value)? data,
    TResult? Function(_StateError<T> value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateLoading<T> value)? loading,
    TResult Function(_StateInitializing<T> value)? initializing,
    TResult Function(_StateData<T> value)? data,
    TResult Function(_StateError<T> value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _StateData<T> extends QueryState<T> {
  const factory _StateData(final T data) = _$_StateData<T>;
  const _StateData._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$$_StateDataCopyWith<T, _$_StateData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_StateErrorCopyWith<T, $Res> {
  factory _$$_StateErrorCopyWith(
          _$_StateError<T> value, $Res Function(_$_StateError<T>) then) =
      __$$_StateErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Object? error, StackTrace? trace});
}

/// @nodoc
class __$$_StateErrorCopyWithImpl<T, $Res>
    extends _$QueryStateCopyWithImpl<T, $Res, _$_StateError<T>>
    implements _$$_StateErrorCopyWith<T, $Res> {
  __$$_StateErrorCopyWithImpl(
      _$_StateError<T> _value, $Res Function(_$_StateError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? trace = freezed,
  }) {
    return _then(_$_StateError<T>(
      error: freezed == error ? _value.error : error,
      trace: freezed == trace
          ? _value.trace
          : trace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_StateError<T> extends _StateError<T> {
  const _$_StateError({this.error, this.trace}) : super._();

  @override
  final Object? error;
  @override
  final StackTrace? trace;

  @override
  String toString() {
    return 'QueryState<$T>.error(error: $error, trace: $trace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StateError<T> &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.trace, trace) || other.trace == trace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(error), trace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StateErrorCopyWith<T, _$_StateError<T>> get copyWith =>
      __$$_StateErrorCopyWithImpl<T, _$_StateError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(T? initial) initializing,
    required TResult Function(T data) data,
    required TResult Function(Object? error, StackTrace? trace) error,
  }) {
    return error(this.error, trace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(T? initial)? initializing,
    TResult? Function(T data)? data,
    TResult? Function(Object? error, StackTrace? trace)? error,
  }) {
    return error?.call(this.error, trace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(T? initial)? initializing,
    TResult Function(T data)? data,
    TResult Function(Object? error, StackTrace? trace)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, trace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StateLoading<T> value) loading,
    required TResult Function(_StateInitializing<T> value) initializing,
    required TResult Function(_StateData<T> value) data,
    required TResult Function(_StateError<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StateLoading<T> value)? loading,
    TResult? Function(_StateInitializing<T> value)? initializing,
    TResult? Function(_StateData<T> value)? data,
    TResult? Function(_StateError<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StateLoading<T> value)? loading,
    TResult Function(_StateInitializing<T> value)? initializing,
    TResult Function(_StateData<T> value)? data,
    TResult Function(_StateError<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _StateError<T> extends QueryState<T> {
  const factory _StateError({final Object? error, final StackTrace? trace}) =
      _$_StateError<T>;
  const _StateError._() : super._();

  Object? get error;
  StackTrace? get trace;
  @JsonKey(ignore: true)
  _$$_StateErrorCopyWith<T, _$_StateError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
