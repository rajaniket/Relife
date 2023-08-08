import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/forgot_password_model.dart';

class ForgotPasswordService {
  Future<ForgotPasswordResponseModel?> forgotPassword(
      ForgortPasswordRequestModel passwordRequestModel) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.forgotPasswordEndpoint);

    final response = await http.post(url, body: passwordRequestModel.toJson());

    log("ForgotPasswordService ______ ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 400) {
      return ForgotPasswordResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
