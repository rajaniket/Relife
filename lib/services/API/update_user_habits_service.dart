import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/update_user_habit_model.dart';

class UpdateUserHabitsService {
  Future<int> updateHabit(UpdateHabitRequestModel updateHabitRequestModel,
      String token, String id) async {
    final url = Uri.https(
      ApiConfig.baseUrl,
      ApiConfig.updateUserHabitEndpoint + '/$id',
    );
    print("updateHabitRequestModel2: ${updateHabitRequestModel.reminderDays}");

    print(DateTime.fromMillisecondsSinceEpoch(
        int.parse(updateHabitRequestModel.reminderTime)));
    final response = await http.post(
      url,
      // body: jsonEncode(
      //     updateHabitRequestModel), // updateHabitRequestModel.toJson(),
      body: updateHabitRequestModel.toJson(),
      headers: {
        "Authorization": token,
      },
    );

    log("UpdateUserHabitsService ______ ${response.body}");
    // print(
    //     "update Habit Response after edit: ${updateHabitRequestModel.toJson()}");
    return response.statusCode;
  }
}
