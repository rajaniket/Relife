import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/get_profile_model.dart';
import 'package:relife/ui/pages/error_page/error_page.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/pages/payment/payment_page.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class GetProfileService {
  Future<ViewProfileResponseModel?> getProfile(
      String token, BuildContext context) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.getProfileEndpoint);

    final response = await http.get(url, headers: {'Authorization': token});

    log("GetProfileService ______ ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 400) {
      return ViewProfileResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false);
    } else if (response.statusCode == 402) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentPage(),
        ),
        (route) => false,
      );
    } else if (response.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong !!!'),
          backgroundColor: Color(0xffDF532B),
        ),
      );
      navigatorPush(
        context,
        const ErrorPage(),
      );
    } else {
      // debugPrint(response.body);
      return ViewProfileResponseModel.fromJson(jsonDecode(response.body));
    }
  }
}
