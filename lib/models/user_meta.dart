import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_5_firebase_auth_firestore/models/login_type_enum.dart';

class UserMeta extends Equatable {
  final String name;
  final String email;
  final LoginType loginType;

  const UserMeta({
    required this.name,
    required this.email,
    required this.loginType,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'loginType': loginType.name};
  }

  IconData get loginTypeIcon {
    switch (loginType) {
      case LoginType.email:
        return Icons.email;
      case LoginType.google:
        return Icons.g_mobiledata;
      case LoginType.facebook:
        return Icons.facebook;
    }
  }

  factory UserMeta.fromMap(Map<String, dynamic> map) {
    return UserMeta(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      loginType: LoginType.values.firstWhere(
        (e) => e.name == map['loginType'],
        orElse: () => LoginType.email,
      ),
    );
  }

  @override
  String toString() =>
      'UserMeta(name: $name, email: $email, loginType: $loginType)';

  @override
  List<Object> get props => [name, email, loginType];

  UserMeta copyWith({String? name, String? email, LoginType? loginType}) {
    return UserMeta(
      name: name ?? this.name,
      email: email ?? this.email,
      loginType: loginType ?? this.loginType,
    );
  }
}
