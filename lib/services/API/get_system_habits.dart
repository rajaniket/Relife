import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/get_system_habits_model.dart';
import 'package:relife/ui/pages/payment/payment_page.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class GetSystemHabitsService {
  Future<GetSystemHabitsModel?> getSystemHabit(
      String token, BuildContext context) async {
    final url =
        Uri.http(ApiConfig.baseUrl, ApiConfig.getStystemAllHabitEndpoint);

    final response = await http.get(url, headers: {
      'Authorization': token,
    });
    log("GetSystemHabitsService ______ ${response.body}");
    if (response.statusCode == 200) {
      return GetSystemHabitsModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 402) {
      navigatorPush(
        context,
        const PaymentPage(),
      );
    }
  }
}
