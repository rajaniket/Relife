import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancleSubscriptionService {
  Future<bool?> cancleSubscription() async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.cancleSubEndpoint);
    final token = await getsharedToken();
    final response = await http.post(url, headers: {'Authorization': token!});

    log("CancleSubscriptionService ______ ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}
