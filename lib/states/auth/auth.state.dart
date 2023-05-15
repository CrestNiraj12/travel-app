import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traveller/models/user.dart';

part 'auth.state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initializing() = _AuthInitializing;
  const factory AuthState.loading() = _AuthLoading;
  const factory AuthState.error(String? err) = _AuthStateError;
  const factory AuthState.user(User? user, String? token) = _AuthStateUser;

  User? get user => maybeMap(
        user: (_AuthStateUser d) => d.user,
        orElse: () => null,
      );

  String? get token => maybeMap(
        user: (_AuthStateUser d) => d.token,
        orElse: () => null,
      );

  String? get err => maybeMap(
        error: (_AuthStateError e) => e.err,
        orElse: () => null,
      );

  get hasUser => user != null;
  get hasToken => token != null;
  get hasError => err != null;

  bool get isInitializing {
    return this is _AuthInitializing;
  }
}
