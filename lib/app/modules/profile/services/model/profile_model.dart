import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String uid;
  final String email;
  final String? username;
  final String? bio;
  final String? profileImageUrl;

  ProfileModel({required this.uid, required this.email, this.username, this.bio, this.profileImageUrl});

  factory ProfileModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProfileModel(uid: doc.id, email: data['email'] ?? '', username: data['username'], bio: data['bio'], profileImageUrl: data['profileImageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'username': username, 'bio': bio, 'profileImageUrl': profileImageUrl};
  }
}
