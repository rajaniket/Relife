import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/update_profile_model.dart';

class UpdateProfileService {
  Future<bool> updateProfile(
      UpdateProfileModel updateProfileModel, String token) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.updateProfileEndpoint);

    final response = await http.post(
      url,
      body: updateProfileModel.toJson(),
      headers: {"Authorization": token},
    );

    log("UpdateProfileService ______ ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
