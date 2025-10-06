import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final User _user;

  AppUser(this._user);

  String get uid => _user.uid;

  String get email => _user.email!;
}
