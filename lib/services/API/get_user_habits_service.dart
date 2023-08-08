import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';
import 'package:relife/ui/pages/error_page/error_page.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/pages/payment/payment_page.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUSerAllHabitsService {
  Future<GetUserAllHabitsModel?> getUserHabits(
      String token, BuildContext context) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.getUserAllHabitEndpoint);

    try {
      final response = await http.get(url, headers: {'Authorization': token});

      log("GetUSerAllHabitsService ______ ${response.body}");
      if (response.statusCode == 200) {
        return GetUserAllHabitsModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false);
      } else if (response.statusCode == 402) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plan expired! Please renew your plan to login.'),
            backgroundColor: Color(0xffDF532B),
          ),
        );
        navigatorPush(context, const PaymentPage());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong !!!'),
            backgroundColor: Color(0xffDF532B),
          ),
        );
        navigatorPush(context, const ErrorPage());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeSharedService() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
  }
}
