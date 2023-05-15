import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/states/auth_redirection/auth_redirection.notifier.dart';
import 'package:traveller/states/auth_redirection/navigation_flow.state.dart';

final authRedirectionProvider =
    StateNotifierProvider<AuthRedirectionNotifier, NavigationFlowState>(
  (ref) => AuthRedirectionNotifier(ref),
);
