import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_5_firebase_auth_firestore/models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository._internal(this._auth, this._googleSignIn);

  static final AuthRepository instance = AuthRepository._internal(
    FirebaseAuth.instance,
    GoogleSignIn.instance,
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

  // delete account method
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      log('Error in deleteAccount: $e');
      rethrow;
    }
  }

  // TODO: Implement Google sign-in method
  Future<User?> signInWithGoogle() async {
    final signIn = _googleSignIn;
    try {
      await signIn.initialize();
    } catch (_) {
      return null;
    }

    GoogleSignInAccount? account;
    try {
      final result = signIn.attemptLightweightAuthentication();
      if (result is Future<GoogleSignInAccount?>) {
        account = await result;
      }
    } catch (_) {}

    if (account == null) {
      // Need explicit user interaction. Use authenticate() when supported.
      try {
        if (signIn.supportsAuthenticate()) {
          account = await signIn.authenticate();
        } else {
          // On web you should present the provided button from web sdk; here we
          // can't render UI, so just return null to let caller trigger UI.
          return null;
        }
      } on GoogleSignInException catch (e) {
        // User canceled or other failure; treat as no sign-in.
        if (e.code == GoogleSignInExceptionCode.canceled) return null;
        return null;
      } catch (_) {
        return null;
      }
    }

    // At this point analyzer considers account non-null; proceed or let exception surface if unexpected.

    // Obtain tokens needed for Firebase credential.
    try {
      final authTokens = account.authentication;
      // google_sign_in 7.x may not expose an accessToken here without explicit
      // authorization scopes; for Firebase basic sign-in the idToken is enough.
      final credential = GoogleAuthProvider.credential(
        idToken: authTokens.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  // TODO: Implement Facebook sign-in method
}
