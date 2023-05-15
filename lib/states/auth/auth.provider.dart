import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/states/auth/auth.notifier.dart';
import 'package:traveller/states/auth/auth.state.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(ref));
