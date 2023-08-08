import 'package:flutter/material.dart';
import 'package:relife/model/service%20model/payment_model.dart';
import 'package:relife/services/API/payment_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentProvider extends ChangeNotifier {
  String _paymentUrl = '';
  bool _isLoading = false;
  bool _isLinkGenerated = false;

  PaymentModel? paymentModel;

  String get paymentUrl => _paymentUrl;
  bool get isLinkGenerated => _isLinkGenerated;
  bool get isLoading => _isLoading;

  Future<void> makePaymentFun(String plan, BuildContext context) async {
    setLoading(true);
    final id = await getsharedTokenId();

    paymentModel = await PaymentService().makePayment(plan, id!);
    if (paymentModel != null) {
      setPaymentUrl(paymentModel!.details.shortUrl);
      setGenerated(true);
      setLoading(false);
    }
  }

  Future<String?> getsharedTokenId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  void setPaymentUrl(String val) {
    _paymentUrl = val;
    notifyListeners();
  }

  void setGenerated(bool val) {
    _isLinkGenerated = val;
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
