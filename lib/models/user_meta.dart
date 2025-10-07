import 'package:equatable/equatable.dart';

/* We are going to store for each user 
- Name
- Email
- Login Type (Google, Facebook, Email)

and store the data in Firestore under a collection named "users"
and for each user document, we will use the user's UID as the document ID.
users collection
  |
  |--- userUID (document)
         |
         |--- name: "User's Name"
         |--- email: "user@example.com"
          |--- loginType: "google" / "facebook" / "email"
*/

enum LoginType { google, facebook, email }

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
