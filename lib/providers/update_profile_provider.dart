import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/update_profile_model.dart';
import 'package:relife/services/API/update_profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileProvider extends ChangeNotifier {
  String _bio = '';

  UpdateProfileModel updateProfileModel = UpdateProfileModel(bio: 'bio');

  String get bio => _bio;

  updateProfile() async {
    String? token = await getsharedToken();
    final result =
        await UpdateProfileService().updateProfile(updateProfileModel, token!);

    if (result) {
      setBio(updateProfileModel.bio);
    } else {
      setBio(' ');
    }
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  setBio(String value) {
    _bio = value;
    notifyListeners();
  }
}
