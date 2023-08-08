import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/get_payment_details.dart';

class GetPaymentServiceDetials {
  Future<PaymentDetailsModel?> getPaymentDetails(String token) async {
    final url = Uri.https(
      ApiConfig.baseUrl,
      ApiConfig.paymentDetailsEndpoint,
    );
    final response = await http.get(
      url,
      headers: {'Authorization': token},
    );
    log("GetPaymentServiceDetials ______ ${response.body}");
    if (response.statusCode == 200) {
      return PaymentDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
