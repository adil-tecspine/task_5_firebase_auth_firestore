import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_5_firebase_auth_firestore/models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository._internal(this._auth);

  static final AuthRepository instance = AuthRepository._internal(
    FirebaseAuth.instance,
  );

  factory AuthRepository() => instance;

  // sign in with email and password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  // login with email and password
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Error in createUserWithEmailAndPassword: $e');
    }
    return null;
  }

  // logout
  Future<void> signOut() {
    return _auth.signOut();
  }

  AppUser? get currentUser => _convertUser(_auth.currentUser);

  /// Notifies about changes to the user's sign-in state (such as sign-in or
  /// sign-out).
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(_convertUser);
  }

  /// Helper method to convert a [User] to an [AppUser]
  AppUser? _convertUser(User? user) => user != null ? AppUser(user) : null;

  // TODO: Implement Google sign-in method

  // TODO: Implement Facebook sign-in method
}
