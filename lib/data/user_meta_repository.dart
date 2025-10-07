import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_5_firebase_auth_firestore/models/user_meta.dart';

class UserMetaRepository {
  final FirebaseFirestore _firestore;

  UserMetaRepository._internal(this._firestore);

  static final UserMetaRepository instance = UserMetaRepository._internal(
    FirebaseFirestore.instance,
  );

  factory UserMetaRepository() => instance;

  Future<void> createUserMeta(String uid, UserMeta userMeta) async {
    await _firestore.collection('users').doc(uid).set(userMeta.toMap());
  }

  Future<UserMeta?> getUserMeta(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserMeta.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
