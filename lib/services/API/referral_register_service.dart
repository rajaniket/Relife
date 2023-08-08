import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/referral_register_model.dart';

class ReferralRegisterService {
  Future<int?> referralRegister(
      ReferralRegisterModel referralRegisterModel, String referralId) async {
    final url = Uri.https(
      ApiConfig.baseUrl,
      ApiConfig.waitlistRegisterEndpoint,
      {'referral_id': referralId},
    );

    final response = await http.post(url, body: referralRegisterModel.toJson());
    log("ReferralRegisterService ______ ${response.body}");
    if (response.statusCode == 200) {
      // print("referal :    $response");
      return 200;
    } else {
      return null;
    }
  }
}
