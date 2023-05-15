import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/main.dart';
import 'package:traveller/models/user.dart';
import 'package:traveller/services/auth_service.dart';
import 'package:traveller/states/auth/auth.state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref) : super(const AuthState.initializing());

  final Ref ref;

  Future<String> getDeviceModel() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String device = 'UNKNOWN';
    if (Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;
      device = info.model;
    } else if (Platform.isIOS) {
      final info = await deviceInfoPlugin.iosInfo;
      device = info.utsname.machine;
    }
    return device;
  }

  Future<void> authWithToken() async {
    try {
      if (state.hasToken) {
        final user = await ref.read(authServiceProvider).getUser();
        state = AuthState.user(user, state.token);
      } else {
        throw DioErrorType.connectionTimeout;
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      final error = e.response?.statusCode == 401
          ? "Session expired!"
          : "Connection Error!";
      state = AuthState.error(error);
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    globalScaffoldKey.currentState?.removeCurrentSnackBar();
    final device = await getDeviceModel();

    final creds = {
      'email': email,
      'password': password,
      'device_name': device,
    };

    try {
      if (!state.hasToken) {
        String token = await ref
            .read(authServiceProvider)
            .loginWithEmailPassword(creds: creds);
        state = AuthState.user(null, token);
      }
      authWithToken();
    } on DioError catch (e) {
      final error = e.response?.statusCode == 422
          ? "Email and password do not match!"
          : "Error logging in!";
      state = AuthState.error(error);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    state = const AuthState.loading();
    globalScaffoldKey.currentState?.removeCurrentSnackBar();

    final device = await getDeviceModel();

    final creds = {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'name': name,
      'device_name': device,
    };

    try {
      String token =
          await ref.read(authServiceProvider).signUpWithEmail(creds: creds);
      state = AuthState.user(null, token);
      authWithToken();
    } on DioError catch (e) {
      String error = "Error while signing up";
      if (e.response?.statusCode == 422) {
        final errors = e.response!.data['errors'];
        if (errors != null && errors['email'] != null) {
          error = "Email is already registered!";
        }
      }

      state = AuthState.error(error);
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  // Future<fb.UserCredential?> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   if (googleUser == null) {
  //     return null;
  //   }

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   // Create a new credential
  //   final credential = fb.GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await fb.FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // Future<void> loginWithGoogle() async {
  //   try {
  //     await signInWithGoogle();
  //     fb.User? user = fb.FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final deviceInfo = DeviceInfoPlugin();
  //       var model = 'UNKNOWN';

  //       if (Platform.isAndroid) {
  //         final info = await deviceInfo.androidInfo;
  //         model = info.model;
  //       } else if (Platform.isIOS) {
  //         final info = await deviceInfo.iosInfo;
  //         model = info.utsname.machine;
  //       }

  //       Map creds = {
  //         "uid": user.uid,
  //         "name": user.displayName,
  //         "email": user.email,
  //         "device_name": model,
  //         "avatar": user.photoURL,
  //       };

  //       Response response = await dio().post('/register', data: creds);
  //       String token = response.data.toString();
  //       final GoogleSignIn googleSignIn = GoogleSignIn();
  //       await googleSignIn.signOut();
  //       await fb.FirebaseAuth.instance.signOut();
  //       loginUser(token: token);
  //     } else {
  //       _absorbing = false;
  //     }
  //   } on DioError catch (e) {
  //     if (e.response!.statusCode == 422) {
  //       final errors = e.response!.data['errors'];
  //       if (errors != null && errors['email'] != null) {
  //         globalScaffoldKey.currentState?.removeCurrentSnackBar();
  //         globalScaffoldKey.currentState?.showSnackBar(
  //           showSnackBar(
  //             content: "Email is already registered!",
  //             type: SnackbarType.error,
  //           ),
  //         );
  //         return;
  //       }
  //     }
  //     if (kDebugMode) {
  //       print(e.response);
  //     }
  //     globalScaffoldKey.currentState?.removeCurrentSnackBar();
  //     globalScaffoldKey.currentState?.showSnackBar(
  //       showSnackBar(
  //         content: "Error while logging in!",
  //         type: SnackbarType.error,
  //       ),
  //     );
  //   } catch (e) {
  //     if (e is fb.FirebaseAuthException) {
  //       globalScaffoldKey.currentState?.showSnackBar(
  //         showSnackBar(
  //           content: e.message ?? "Error while logging in!",
  //           type: SnackbarType.error,
  //         ),
  //       );
  //     }
  //   }
  // }

  Future<void> logoutUser() async {
    final scaffoldMessenger = globalScaffoldKey.currentState;
    try {
      await ref.read(authServiceProvider).signOut();
      state = AuthState.user(null, null);
      scaffoldMessenger?.removeCurrentSnackBar();
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: 'Successfully logged out!',
          type: SnackbarType.success,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      final error = "Error while logging out!";
      state = AuthState.error(error);
    }
  }

  Future<void> refreshUser() async {
    Response response = await ref.read(httpClientProvider).get('/user');
    final user = User.fromJson(response.data);
    state = AuthState.user(user, state.token);
  }
}
