import 'dart:convert';
import 'dart:developer';

import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/reset_password_model.dart';
import 'package:http/http.dart' as http;

class ResetPasswordService {
  Future<ResetPasswordResponseModel?> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel, String token) async {
    final url = Uri.https(
        ApiConfig.baseUrl, ApiConfig.resetPasswordEndpoint, {'token': token});

    final response = await http.post(
      url,
      body: resetPasswordRequestModel.toJson(),
    );

    log("ResetPasswordService ______ ${response.body}");

    if (response.statusCode == 200) {
      return ResetPasswordResponseModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      return null;
    }
  }
}
