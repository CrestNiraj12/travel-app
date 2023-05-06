// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_loading.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ListLoadingState<T> {
  List<T> get data => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListLoadingStateCopyWith<T, ListLoadingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListLoadingStateCopyWith<T, $Res> {
  factory $ListLoadingStateCopyWith(
          ListLoadingState<T> value, $Res Function(ListLoadingState<T>) then) =
      _$ListLoadingStateCopyWithImpl<T, $Res, ListLoadingState<T>>;
  @useResult
  $Res call({List<T> data, String error, bool isLoading});
}

/// @nodoc
class _$ListLoadingStateCopyWithImpl<T, $Res, $Val extends ListLoadingState<T>>
    implements $ListLoadingStateCopyWith<T, $Res> {
  _$ListLoadingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ListLoadingStateCopyWith<T, $Res>
    implements $ListLoadingStateCopyWith<T, $Res> {
  factory _$$_ListLoadingStateCopyWith(_$_ListLoadingState<T> value,
          $Res Function(_$_ListLoadingState<T>) then) =
      __$$_ListLoadingStateCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> data, String error, bool isLoading});
}

/// @nodoc
class __$$_ListLoadingStateCopyWithImpl<T, $Res>
    extends _$ListLoadingStateCopyWithImpl<T, $Res, _$_ListLoadingState<T>>
    implements _$$_ListLoadingStateCopyWith<T, $Res> {
  __$$_ListLoadingStateCopyWithImpl(_$_ListLoadingState<T> _value,
      $Res Function(_$_ListLoadingState<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(_$_ListLoadingState<T>(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ListLoadingState<T> extends _ListLoadingState<T> {
  _$_ListLoadingState(
      {this.data = const [], this.error = '', this.isLoading = false})
      : super._();

  @override
  @JsonKey()
  final List<T> data;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ListLoadingState<$T>(data: $data, error: $error, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListLoadingState<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), error, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ListLoadingStateCopyWith<T, _$_ListLoadingState<T>> get copyWith =>
      __$$_ListLoadingStateCopyWithImpl<T, _$_ListLoadingState<T>>(
          this, _$identity);
}

abstract class _ListLoadingState<T> extends ListLoadingState<T> {
  factory _ListLoadingState(
      {final List<T> data,
      final String error,
      final bool isLoading}) = _$_ListLoadingState<T>;
  _ListLoadingState._() : super._();

  @override
  List<T> get data;
  @override
  String get error;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_ListLoadingStateCopyWith<T, _$_ListLoadingState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
