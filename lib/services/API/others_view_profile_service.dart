import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/others_profile_model.dart';

class OthersProfileViewService {
  Future<OthersProfileModel?> getOthersProfile(String id, String token) async {
    final url =
        Uri.https(ApiConfig.baseUrl, '${ApiConfig.getProfileEndpoint}/$id');

    final response = await http.get(url, headers: {'Authorization': token});
    log("OthersProfileViewService ______ ${response.body}");
    if (response.statusCode == 200) {
      //debugPrint(response.body);
      return OthersProfileModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
