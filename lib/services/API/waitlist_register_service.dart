import 'dart:developer';

import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/waitlist_register_model.dart';
import 'package:http/http.dart' as http;

class WaitlistRegisterService {
  Future<int?> waitlistRegister(
      WaitlistRegisterModel waitlistRegisterModel, String waitlistId) async {
    final url = Uri.https(
      ApiConfig.baseUrl,
      ApiConfig.waitlistRegisterEndpoint,
      {
        'waitlist_id': waitlistId,
      },
    );

    final response = await http.post(url, body: waitlistRegisterModel.toJson());

    log("WaitlistRegisterService ______ ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 200;
    } else {
      return null;
    }
  }
}
