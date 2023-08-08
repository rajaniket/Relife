import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/create_habit_model.dart';

class AddUserHabitsService {
  Future<int> createHabit(
      CreateHabitRequestModel createHabitRequestModel, String token) async {
    final url = Uri.https(ApiConfig.baseUrl, ApiConfig.createUserHabitEndpoint);

    final response = await http.post(
      url,
      body: createHabitRequestModel.toJson(),
      headers: {
        "Authorization": token,
      },
    );
    log("AddUserHabitsService______ ${response.body}");
    return response.statusCode; //  will return status code like 200 and other
  }
}
