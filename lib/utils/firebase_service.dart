import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signInWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    log(e.message ?? 'Error');
  } catch (e) {
    log('$e');
  }
  return null;
}

@override
Future<User?> createUserWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    final auth = FirebaseAuth.instance;
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    log(e.message ?? "Error");
  } catch (e) {
    log('$e');
  }
  return null;
}
