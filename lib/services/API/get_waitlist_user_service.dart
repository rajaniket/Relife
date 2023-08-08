import 'dart:convert';
import 'dart:developer';

import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/get_waitlist_user_model.dart';
import 'package:http/http.dart' as http;

class GetWaitlistUserService {
  Future<GetWaitlistUserModel?> getWaitlist(String id) async {
    final url = Uri.https(
        ApiConfig.baseUrl, ApiConfig.getWaitlistUserEndpoint + '/$id');

    final response = await http.get(url);

    log("GetWaitlistUserService ______ ${response.body}");

    if (response.statusCode == 200) {
      return GetWaitlistUserModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
