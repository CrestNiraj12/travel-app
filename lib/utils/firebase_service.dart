import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';

Future<User?> signInWithEmailAndPassword({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: 'Successfully logged in',
      ),
    );

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    log(e.message ?? 'Error');
    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: e.message ?? 'Error while logging in',
        type: SnackbarType.error,
      ),
    );
  } catch (e) {
    log('$e');
    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: 'Error while logging in',
        type: SnackbarType.error,
      ),
    );
  }
  return null;
}

@override
Future<User?> createUserWithEmailAndPassword({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredential.user?.updateDisplayName(name);

    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: 'Successfully registered your account',
      ),
    );

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    log(e.message ?? "Error");
    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: e.message ?? 'Error while signing up',
        type: SnackbarType.error,
      ),
    );
  } catch (e) {
    log('$e');
    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: 'Error while signing up',
        type: SnackbarType.error,
      ),
    );
  }
  return null;
}
