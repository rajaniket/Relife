import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/login_model.dart';

class ApiService {
  Future<LoginResponseModel?> login(LoginRequestModel? requestModel) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.loginEndpoint);

    final response = await http.post(url, body: requestModel!.toJson());

    log("login service ______ ${response.body}");

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    }
  }
}
