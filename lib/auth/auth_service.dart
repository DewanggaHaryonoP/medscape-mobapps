import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred;
    } on FirebaseAuthException catch (e) {
      log("Firebase Auth Exception: ${e.message}");
      throw e; // rethrow the exception for handling it in the UI layer
    } catch (e) {
      log("Something went wrong: $e");
      throw e; // rethrow the exception for handling it in the UI layer
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null && !cred.user!.emailVerified) {
        await _auth.signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email to log in.',
        );
      }
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("Firebase Auth Exception: ${e.message}");
      throw e; // rethrow the exception for handling it in the UI layer
    } catch (e) {
      log("Something went wrong: $e");
      throw e; // rethrow the exception for handling it in the UI layer
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong: $e");
    }
  }
}
