import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/get_particuar_system_habit_model.dart';

class GetParticularSystemHabitsService {
  Future<GetParticularSysytemHabitModel?> getParticularSystemHabit(
      String token, String habitId) async {
    final url = Uri.http(ApiConfig.baseUrl,
        ApiConfig.getParticukarSystemHabitEndpoint + '/$habitId');

    final response = await http.get(url, headers: {
      'Authorization': token,
    });

    log("GetParticularSystemHabitsService ______ ${response.body}");

    if (response.statusCode == 200) {
      return GetParticularSysytemHabitModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
