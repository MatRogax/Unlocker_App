import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_unloucker/app/modules/profile/services/model/profile_model.dart';

abstract class AbstractProfileRepository {
  Future<void> createProfile(User user, {String? username});
  Future<ProfileModel> getProfile(String uid);
  Future<void> updateProfile(String uid, Map<String, dynamic> data);
  Future<void> deleteProfile(String uid);
}

class ProfileRepository implements AbstractProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<ProfileModel> get _profilesCollection => _firestore
      .collection('users')
      .withConverter<ProfileModel>(fromFirestore: (snapshot, _) => ProfileModel.fromFirestore(snapshot), toFirestore: (profile, _) => profile.toJson());

  @override
  Future<void> createProfile(User user, {String? username}) async {
    final newProfile = ProfileModel(uid: user.uid, email: user.email!, username: username ?? user.displayName, bio: "Olá! Sou novo por aqui.");
    await _profilesCollection.doc(user.uid).set(newProfile);
  }

  @override
  Future<ProfileModel> getProfile(String uid) async {
    final doc = await _profilesCollection.doc(uid).get();
    if (!doc.exists) throw Exception("Perfil não encontrado.");
    return doc.data()!;
  }

  @override
  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  @override
  Future<void> deleteProfile(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}
