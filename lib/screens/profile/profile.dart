import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/screens/profile/authenticate.dart';
import 'package:traveller/screens/profile/profile_home.dart';
import 'package:traveller/states/auth/auth.provider.dart';
import 'package:traveller/utils/colors.dart';

class Profile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
        body: Container(
      color: AppColors.primary,
      child: authState.maybeMap(
        user: (value) {
          if (value.hasUser) {
            return ProfileHome(
              user: value.user!,
            );
          }
          return Authenticate();
        },
        loading: (value) => Center(
          child: CircularProgressIndicator(),
        ),
        orElse: () => Authenticate(),
      ),
    ));
  }
}
