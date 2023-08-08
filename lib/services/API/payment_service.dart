import 'dart:convert';
import 'dart:developer';

import 'package:relife/config/api_config.dart';
import 'package:relife/model/service%20model/payment_model.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<PaymentModel?> makePayment(String plan, String id) async {
    final url =
        Uri.https(ApiConfig.baseUrl, ApiConfig.paymentEndpoint + '/$id/$plan');

    try {
      final response = await http.post(url);

      log("PaymentService ______ ${response.body}");

      if (response.statusCode == 200) {
        return PaymentModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
