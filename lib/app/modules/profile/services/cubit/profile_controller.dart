import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_unloucker/app/modules/profile/services/model/profile_model.dart';
import 'package:projeto_unloucker/app/modules/profile/services/repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileController extends Cubit<ProfileState> {
  final AbstractProfileRepository _profileRepository;

  ProfileController({required AbstractProfileRepository profileRepository}) : _profileRepository = profileRepository, super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    emit(ProfileLoading());
    try {
      final profile = await _profileRepository.getProfile(uid);
      emit(ProfileLoadSuccess(profile));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> updateProfile(String uid, {String? username, String? bio, String? profileImageUrl}) async {
    final Map<String, dynamic> dataToUpdate = {};

    if (username != null) dataToUpdate['username'] = username;
    if (bio != null) dataToUpdate['bio'] = bio;
    if (profileImageUrl != null) dataToUpdate['profileImageUrl'] = profileImageUrl;
    if (dataToUpdate.isEmpty) {
      return;
    }
    try {
      await _profileRepository.updateProfile(uid, dataToUpdate);
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
