import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/states/auth/auth.provider.dart';
import 'package:traveller/states/auth/auth.state.dart';
import 'package:traveller/states/bottom_nav.provider.dart';

import 'navigation_flow.state.dart';

/// authentication related navigation flow
class AuthRedirectionNotifier extends StateNotifier<NavigationFlowState> {
  AuthRedirectionNotifier(this.ref)
      : super(const NavigationFlowState.normal()) {
    init();
  }

  final Ref ref;
  StreamSubscription? _authStream;
  AuthState? _authState;

  /// listen to navigation changes and route changes
  void init() {
    _authState = ref.read(authProvider);
    _authStream = ref.read(authProvider.notifier).stream.listen((event) {
      _authState = event;
      _handleStream();
    });
  }

  bool get isAuthenticated {
    return _authState?.hasUser;
  }

  bool get _hasError {
    return _authState?.hasError;
  }

  String get _error {
    return _authState?.err ?? 'Error has occurred!';
  }

  void _handleStream() {
    state.when(
      normal: _handleNormalFlow,
    );
  }

  void _handleNormalFlow() {
    if (_hasError) {
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: _error,
          type: SnackbarType.error,
        ),
      );
    }
    if (isAuthenticated) {
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: "Success",
          type: SnackbarType.success,
        ),
      );
      pageController.jumpToPage(Screens.home);
      ref.read(bottomNavProvider.notifier).state = Screens.home;
    }
  }

  @override
  void dispose() {
    _authStream?.cancel();
    super.dispose();
  }
}
