// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function() loading,
    required TResult Function(String? err) error,
    required TResult Function(User? user, String? token) user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function()? loading,
    TResult? Function(String? err)? error,
    TResult? Function(User? user, String? token)? user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function()? loading,
    TResult Function(String? err)? error,
    TResult Function(User? user, String? token)? user,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthInitializing value) initializing,
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthStateError value) error,
    required TResult Function(_AuthStateUser value) user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthInitializing value)? initializing,
    TResult? Function(_AuthLoading value)? loading,
    TResult? Function(_AuthStateError value)? error,
    TResult? Function(_AuthStateUser value)? user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthInitializing value)? initializing,
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthStateError value)? error,
    TResult Function(_AuthStateUser value)? user,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AuthInitializingCopyWith<$Res> {
  factory _$$_AuthInitializingCopyWith(
          _$_AuthInitializing value, $Res Function(_$_AuthInitializing) then) =
      __$$_AuthInitializingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthInitializingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthInitializing>
    implements _$$_AuthInitializingCopyWith<$Res> {
  __$$_AuthInitializingCopyWithImpl(
      _$_AuthInitializing _value, $Res Function(_$_AuthInitializing) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthInitializing extends _AuthInitializing {
  const _$_AuthInitializing() : super._();

  @override
  String toString() {
    return 'AuthState.initializing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthInitializing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function() loading,
    required TResult Function(String? err) error,
    required TResult Function(User? user, String? token) user,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function()? loading,
    TResult? Function(String? err)? error,
    TResult? Function(User? user, String? token)? user,
  }) {
    return initializing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function()? loading,
    TResult Function(String? err)? error,
    TResult Function(User? user, String? token)? user,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthInitializing value) initializing,
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthStateError value) error,
    required TResult Function(_AuthStateUser value) user,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthInitializing value)? initializing,
    TResult? Function(_AuthLoading value)? loading,
    TResult? Function(_AuthStateError value)? error,
    TResult? Function(_AuthStateUser value)? user,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthInitializing value)? initializing,
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthStateError value)? error,
    TResult Function(_AuthStateUser value)? user,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class _AuthInitializing extends AuthState {
  const factory _AuthInitializing() = _$_AuthInitializing;
  const _AuthInitializing._() : super._();
}

/// @nodoc
abstract class _$$_AuthLoadingCopyWith<$Res> {
  factory _$$_AuthLoadingCopyWith(
          _$_AuthLoading value, $Res Function(_$_AuthLoading) then) =
      __$$_AuthLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthLoadingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthLoading>
    implements _$$_AuthLoadingCopyWith<$Res> {
  __$$_AuthLoadingCopyWithImpl(
      _$_AuthLoading _value, $Res Function(_$_AuthLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_AuthLoading extends _AuthLoading {
  const _$_AuthLoading() : super._();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function() loading,
    required TResult Function(String? err) error,
    required TResult Function(User? user, String? token) user,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function()? loading,
    TResult? Function(String? err)? error,
    TResult? Function(User? user, String? token)? user,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function()? loading,
    TResult Function(String? err)? error,
    TResult Function(User? user, String? token)? user,
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
    required TResult Function(_AuthInitializing value) initializing,
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthStateError value) error,
    required TResult Function(_AuthStateUser value) user,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthInitializing value)? initializing,
    TResult? Function(_AuthLoading value)? loading,
    TResult? Function(_AuthStateError value)? error,
    TResult? Function(_AuthStateUser value)? user,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthInitializing value)? initializing,
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthStateError value)? error,
    TResult Function(_AuthStateUser value)? user,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AuthLoading extends AuthState {
  const factory _AuthLoading() = _$_AuthLoading;
  const _AuthLoading._() : super._();
}

/// @nodoc
abstract class _$$_AuthStateErrorCopyWith<$Res> {
  factory _$$_AuthStateErrorCopyWith(
          _$_AuthStateError value, $Res Function(_$_AuthStateError) then) =
      __$$_AuthStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String? err});
}

/// @nodoc
class __$$_AuthStateErrorCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateError>
    implements _$$_AuthStateErrorCopyWith<$Res> {
  __$$_AuthStateErrorCopyWithImpl(
      _$_AuthStateError _value, $Res Function(_$_AuthStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? err = freezed,
  }) {
    return _then(_$_AuthStateError(
      freezed == err
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthStateError extends _AuthStateError {
  const _$_AuthStateError(this.err) : super._();

  @override
  final String? err;

  @override
  String toString() {
    return 'AuthState.error(err: $err)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateError &&
            (identical(other.err, err) || other.err == err));
  }

  @override
  int get hashCode => Object.hash(runtimeType, err);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateErrorCopyWith<_$_AuthStateError> get copyWith =>
      __$$_AuthStateErrorCopyWithImpl<_$_AuthStateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function() loading,
    required TResult Function(String? err) error,
    required TResult Function(User? user, String? token) user,
  }) {
    return error(err);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function()? loading,
    TResult? Function(String? err)? error,
    TResult? Function(User? user, String? token)? user,
  }) {
    return error?.call(err);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function()? loading,
    TResult Function(String? err)? error,
    TResult Function(User? user, String? token)? user,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(err);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthInitializing value) initializing,
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthStateError value) error,
    required TResult Function(_AuthStateUser value) user,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthInitializing value)? initializing,
    TResult? Function(_AuthLoading value)? loading,
    TResult? Function(_AuthStateError value)? error,
    TResult? Function(_AuthStateUser value)? user,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthInitializing value)? initializing,
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthStateError value)? error,
    TResult Function(_AuthStateUser value)? user,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthStateError extends AuthState {
  const factory _AuthStateError(final String? err) = _$_AuthStateError;
  const _AuthStateError._() : super._();

  String? get err;
  @JsonKey(ignore: true)
  _$$_AuthStateErrorCopyWith<_$_AuthStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthStateUserCopyWith<$Res> {
  factory _$$_AuthStateUserCopyWith(
          _$_AuthStateUser value, $Res Function(_$_AuthStateUser) then) =
      __$$_AuthStateUserCopyWithImpl<$Res>;
  @useResult
  $Res call({User? user, String? token});
}

/// @nodoc
class __$$_AuthStateUserCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_AuthStateUser>
    implements _$$_AuthStateUserCopyWith<$Res> {
  __$$_AuthStateUserCopyWithImpl(
      _$_AuthStateUser _value, $Res Function(_$_AuthStateUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? token = freezed,
  }) {
    return _then(_$_AuthStateUser(
      freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthStateUser extends _AuthStateUser {
  const _$_AuthStateUser(this.user, this.token) : super._();

  @override
  final User? user;
  @override
  final String? token;

  @override
  String toString() {
    return 'AuthState.user(user: $user, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateUser &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthStateUserCopyWith<_$_AuthStateUser> get copyWith =>
      __$$_AuthStateUserCopyWithImpl<_$_AuthStateUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function() loading,
    required TResult Function(String? err) error,
    required TResult Function(User? user, String? token) user,
  }) {
    return user(this.user, token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function()? loading,
    TResult? Function(String? err)? error,
    TResult? Function(User? user, String? token)? user,
  }) {
    return user?.call(this.user, token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function()? loading,
    TResult Function(String? err)? error,
    TResult Function(User? user, String? token)? user,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this.user, token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthInitializing value) initializing,
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthStateError value) error,
    required TResult Function(_AuthStateUser value) user,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthInitializing value)? initializing,
    TResult? Function(_AuthLoading value)? loading,
    TResult? Function(_AuthStateError value)? error,
    TResult? Function(_AuthStateUser value)? user,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthInitializing value)? initializing,
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthStateError value)? error,
    TResult Function(_AuthStateUser value)? user,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class _AuthStateUser extends AuthState {
  const factory _AuthStateUser(final User? user, final String? token) =
      _$_AuthStateUser;
  const _AuthStateUser._() : super._();

  User? get user;
  String? get token;
  @JsonKey(ignore: true)
  _$$_AuthStateUserCopyWith<_$_AuthStateUser> get copyWith =>
      throw _privateConstructorUsedError;
}
