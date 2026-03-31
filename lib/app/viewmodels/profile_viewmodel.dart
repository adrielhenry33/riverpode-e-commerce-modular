import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewmodel extends StateNotifier<UserModel?> {
  ProfileViewmodel() : super(null);

  Future<void> setProfilePick() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        state = state!.copyWith(picture: pickedFile);
      }
    } catch (e) {
      state = null;
    }
  }
}

final userViewModelProvider =
    StateNotifierProvider<ProfileViewmodel, UserModel?>((ref) {
      return ProfileViewmodel();
    });
